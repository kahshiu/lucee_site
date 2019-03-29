const mappingScheme = [{
    mapId: 'base_definitions'
    ,idProperty: 'd_item_name'
    ,properties: ['d_item_description','d_item_i','d_item_va']
  }, {
    mapId: 'base_definitions_group'
    ,idProperty: 'd_name'
    ,collections: [
        {mapId:'base_definitions',name:'def_items'}
    ]
  }, {
    mapId: 'file_annual'
    ,idProperty: ['file_id','file_year']
    ,properties: ['date_create','date_engage','date_work_start','date_work_end','date_target_end']
  }, {
    mapId: 'file'
    ,idProperty: 'file_id'
    ,properties: ['file_name','file_type','file_deadline','file_status']
    ,collection: [
      {mapId:'file_annual',name:'file_annual'}
    ]
  }, {
    mapId: 'group_member'
    ,idProperty: ['group_id','member_type','member_id']
    ,properties: ['member_seq']
  }, {
    mapId: 'grouping'
    ,idProperty: 'group_id'
    ,properties: ['group_name']
    ,collections: [
      {mapId:'group_member',name:'group_member'}
      ,{mapId:'file',name:'file'}
    ]
  }
];
