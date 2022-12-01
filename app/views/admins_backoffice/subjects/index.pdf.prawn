prawn_document do |pdf|
  pdf.text 'Listando assuntos', align: :center, size: 24
  pdf.move_down 20
  pdf.table @subjects.map{ |s| [s.id, s.description] }
end