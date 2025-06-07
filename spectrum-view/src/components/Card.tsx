const Card = ({ title, value }: { title: string; value: string }) => (
  <div className="bg-card p-4 rounded-lg shadow-sm border border-border">
    <h3 className="text-sm text-muted-foreground mb-2">{title}</h3>
    <p className="text-2xl font-semibold">{value}</p>
  </div>
);

export default Card;
