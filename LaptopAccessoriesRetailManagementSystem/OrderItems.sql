CREATE PROCEDURE uspAddOrderItem
    @Quantity NVARCHAR(100),
    @OrderId BIGINT,
    @ProductId BIGINT,
    @UnitPrice Money
AS
BEGIN
    INSERT INTO [msistoredb].[orderitem] (
        Quantity, OrderId, ProductId, UnitPrice
    )
    VALUES (
        @Quantity, @OrderId, @ProductId, @UnitPrice
    )
END


CREATE PROCEDURE uspUpdateOrderItem
    @id BIGINT,
    @Quantity INT,
    @OrderId BIGINT,
    @ProductId BIGINT,
    @UnitPrice Money
AS
BEGIN
    UPDATE [msistoredb].[orderitem] 
    SET
        Quantity = @Quantity,
        OrderId = @OrderId,
        ProductId = @ProductId,
        UnitPrice = @UnitPrice
    WHERE id = @id
END



CREATE PROCEDURE uspDeleteOrderItem
    @id BIGINT
AS
BEGIN
    DELETE FROM [msistoredb].[orderitem]
    WHERE id = @id
END