defmodule Juno.Uploads.AWS do
  import Juno.Config, only: [config!: 2]

  @http_method :put

  def aws!(key) do
    config!(:aws, key)
  end

  def s3!(key) do
    config!(:s3, key)
  end

  def s3_base_url do
    "#{aws!(:scheme)}://#{s3!(:bucket)}.s3.#{s3!(:region)}.#{aws!(:host)}"
  end

  def s3_url(file_name) do
    "#{s3_base_url()}/#{file_name}"
  end

  def generate_presigned_url(file_name, file_size, mime_type) do
    ExAws.S3.presigned_url(
      ExAws.Config.new(:s3, []),
      @http_method,
      s3!(:bucket),
      file_name,
      virtual_host: true,
      query_params: [
        {"content-type", mime_type},
        {"content-length-range", "#{file_size},#{file_size}"}
      ]
    )
  end
end
