module AdminsBackofficeHelper
  def translate_attribute(model, method)
    model.human_attribute_name(method)
  end
end
