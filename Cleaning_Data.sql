Select * from portfolio.dbo.[NashvilleHousing ];
Select SaleDate,
CONVERT(Date, SaleDate) from portfolio.dbo.[NashvilleHousing ];

Update [NashvilleHousing ]
Set SaleDate=Convert(Date,SaleDate);

alter table portfolio.dbo.[NashvilleHousing ]
Add SaleDateConverted Date;

update portfolio..[NashvilleHousing ]
set SaleDateConverted=Convert(Date, SaleDate);

--------------------------
-- populate property address DATA
Select ParcelID,PropertyAddress from portfolio..[NashvilleHousing ] order by ParcelID, PropertyAddress;
    -- Update  portfolio..[NashvilleHousing ]
    -- Set PropertyAddress=(select )


    Select a.ParcelID, a.PropertyAddress , b.ParcelID,b.PropertyAddress, ISNull(a.PropertyAddress,b.PropertyAddress)
     from portfolio..[NashvilleHousing ] a
     join  portfolio..[NashvilleHousing ] b 
     on a.ParcelID=b.ParcelID
     and a.UniqueID<>b.UniqueID

    where a.PropertyAddress is null;
------update the table 
    update a
    Set a.PropertyAddress= ISNull(a.PropertyAddress,b.PropertyAddress)
     from portfolio..[NashvilleHousing ] a
     join  portfolio..[NashvilleHousing ] b 
     on a.ParcelID=b.ParcelID
     and a.UniqueID<>b.UniqueID
    where a.PropertyAddress is null;
-----------Breaking out address into indivisual columns ( Address, city, state)
Select  PropertyAddress,
 substring(PropertyAddress,1, CHARINDEX(',',PropertyAddress)-1)
, substring(PropertyAddress,CHARINDEX(',',PropertyAddress)+1,len(PropertyAddress) )
 from portfolio..[NashvilleHousing ];
----create the address column
alter table [NashvilleHousing ]
add PropertySplitAddress Varchar(50);

Update [NashvilleHousing ]
set PropertySplitAddress=substring(PropertyAddress,1, CHARINDEX(',',PropertyAddress)-1);
-------create city column
alter table [NashvilleHousing ]
add PropertySplitCity Varchar(50);

update [NashvilleHousing ]
set PropertySplitCity=substring(PropertyAddress,CHARINDEX(',',PropertyAddress)+1,len(PropertyAddress) );

---------------Breaking out the owner address
Select PARSENAME(REPLACE(OwnerAddress,',','.'),3),
PARSENAME(REPLACE(OwnerAddress,',','.'),2),
PARSENAME(REPLACE(OwnerAddress,',','.'),1)
from portfolio..[NashvilleHousing ];
------updating and adding columns for owner address
alter table [NashvilleHousing ]
add OwnerSplitAddress Varchar(50);

update [NashvilleHousing ]
set OwnerSplitAddress=PARSENAME(REPLACE(OwnerAddress,',','.'),3);



alter table [NashvilleHousing ]
add OwnerSplitCity Varchar(50);

update [NashvilleHousing ]
set OwnerSplitCity=PARSENAME(REPLACE(OwnerAddress,',','.'),2);

alter table [NashvilleHousing ]
add OwnerSplitState Varchar(50);

update [NashvilleHousing ]
set OwnerSplitState=PARSENAME(REPLACE(OwnerAddress,',','.'),1);

select * from [NashvilleHousing ];
-------Change Y and N to Yes and No in "sold as vacant" field:


select SoldAsVacant,Case 
When SoldAsVacant='Y' OR SoldAsVacant='Yes' Then 'Yes'
When SoldAsVacant='N' OR SoldAsVacant='No' Then 'No'
End 
 from [NashvilleHousing ] order by SoldAsVacant desc;



Update [NashvilleHousing ]
Set SoldAsVacant=Case 
When SoldAsVacant='Y' OR SoldAsVacant='Yes' Then 'Yes'
When SoldAsVacant='N' OR SoldAsVacant='No' Then 'No'
End 
select Distinct SoldAsVacant from portfolio..[NashvilleHousing ];
-----------Remove Duplicate 
with RowNumCTE as(

Select *,
 ROW_NUMBER() over (Partition by 
 ParcelID, PropertyAddress, SaleDate,SalePrice,LegalReference 
 order by UniqueID
 ) row_num
from portfolio..[NashvilleHousing ])
delete from RowNumCTE 
where  row_num>1;

-----Delete Unsued Columns 
Alter table  portfolio..NashvilleHousing 
drop Column SaleDate

Select * from  portfolio..NashvilleHousing ;