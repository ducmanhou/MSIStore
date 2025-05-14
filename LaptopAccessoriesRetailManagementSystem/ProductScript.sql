CREATE PROCEDURE uspAddProduct
    @Name NVARCHAR(100),
    @Description NVARCHAR(200),
    @Detail NVARCHAR(MAX),
    @PldPrice DECIMAL(6,2),
    @NewPrice DECIMAL(6,2),
    @CategoryId BIGINT,
    @Brand_id BIGINT
AS
BEGIN
    INSERT INTO [msistoredb].[product] (
        Name, Description, Detail, OldPrice, NewPrice,
        CategoryId, brand_id
    )
    VALUES (
        @Name, @Description, @Detail, @PldPrice, @NewPrice,
        @CategoryId, @Brand_id
    )
END


CREATE PROCEDURE uspUpdateProduct
    @id BIGINT,
    @Name NVARCHAR(100),
    @Description NVARCHAR(MAX),
    @Detail NVARCHAR(MAX),
    @PldPrice DECIMAL(6,2),
    @NewPrice DECIMAL(6,2),
    @CategoryId BIGINT,
    @Brand_id BIGINT
AS
BEGIN
    UPDATE [msistoredb].[product]
    SET
        Name = @Name,
        Description = @Description,
        Detail = @Detail,
        OldPrice = @PldPrice,
        NewPrice = @NewPrice,
        CategoryId = @CategoryId,
        brand_id = @Brand_id
    WHERE id = @id
END



CREATE PROCEDURE uspDeleteProduct
    @id BIGINT
AS
BEGIN
    DELETE FROM [msistoredb].[product]
    WHERE id = @id
END