<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes" encoding="UTF-8"/>

<xsl:template match="/">
  <html>
  <head>
    <title>City Medical Center - Patient Management System</title>
    <style>
      body {
        font-family: 'Segoe UI', Arial, sans-serif;
        margin: 0;
        padding: 20px;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        min-height: 100vh;
      }
      .container {
        max-width: 1200px;
        margin: 0 auto;
        background: white;
        border-radius: 20px;
        padding: 30px;
        box-shadow: 0 20px 60px rgba(0,0,0,0.3);
      }
      h1 {
        color: #333;
        border-bottom: 3px solid #667eea;
        padding-bottom: 10px;
        margin-top: 0;
      }
      .clinic-header {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        padding: 20px;
        border-radius: 10px;
        margin-bottom: 30px;
      }
      .stats-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 20px;
        margin-bottom: 30px;
      }
      .stat-card {
        background: #f8f9fa;
        padding: 20px;
        border-radius: 10px;
        text-align: center;
        box-shadow: 0 4px 6px rgba(0,0,0,0.1);
      }
      .stat-number {
        font-size: 32px;
        font-weight: bold;
        color: #667eea;
      }
      .section {
        background: #f8f9fa;
        padding: 20px;
        border-radius: 10px;
        margin-bottom: 30px;
      }
      .section h2 {
        color: #333;
        margin-top: 0;
        border-left: 5px solid #667eea;
        padding-left: 15px;
      }
      table {
        width: 100%;
        border-collapse: collapse;
      }
      th {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        padding: 12px;
        text-align: left;
      }
      td {
        padding: 12px;
        border-bottom: 1px solid #ddd;
        background: white;
      }
      tr:hover td {
        background: #f1f3ff;
      }
      .patient-card {
        background: white;
        border-radius: 10px;
        padding: 20px;
        margin-bottom: 15px;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        border-left: 5px solid #667eea;
      }
      .status-badge {
        display: inline-block;
        padding: 5px 15px;
        border-radius: 20px;
        font-weight: bold;
        font-size: 12px;
      }
      .status-active {
        background: #d4edda;
        color: #155724;
      }
      .status-recovery {
        background: #fff3cd;
        color: #856404;
      }
      .status-scheduled {
        background: #cce5ff;
        color: #004085;
      }
      .status-completed {
        background: #e2e3e5;
        color: #383d41;
      }
      .department-tag {
        background: #e3f2fd;
        color: #1976d2;
        padding: 3px 10px;
        border-radius: 15px;
        font-size: 12px;
      }
      .footer {
        text-align: center;
        margin-top: 30px;
        padding-top: 20px;
        border-top: 1px solid #ddd;
        color: #666;
      }
      .search-box {
        margin-bottom: 20px;
        padding: 10px;
        width: 300px;
        border: 2px solid #667eea;
        border-radius: 25px;
        font-size: 16px;
      }
      .emergency-alert {
        background: #ffebee;
        border: 2px solid #f44336;
        border-radius: 10px;
        padding: 15px;
        margin-bottom: 20px;
        animation: pulse 2s infinite;
      }
      @keyframes pulse {
        0% { box-shadow: 0 0 0 0 rgba(244, 67, 54, 0.4); }
        70% { box-shadow: 0 0 0 10px rgba(244, 67, 54, 0); }
        100% { box-shadow: 0 0 0 0 rgba(244, 67, 54, 0); }
      }
    </style>
  </head>
  <body>
    <div class="container">
      <!-- Clinic Header -->
      <xsl:for-each select="clinic">
        <div class="clinic-header">
          <h1><xsl:value-of select="@name"/></h1>
          <p><strong>📍 Address:</strong> <xsl:value-of select="clinic-info/address"/></p>
          <p><strong>📞 Phone:</strong> <xsl:value-of select="clinic-info/phone"/></p>
          <p><strong>🔑 License:</strong> <xsl:value-of select="clinic-info/license"/></p>
        </div>
      </xsl:for-each>

      <!-- Statistics Dashboard -->
      <div class="stats-grid">
        <xsl:for-each select="clinic/statistics">
          <div class="stat-card">
            <div class="stat-number"><xsl:value-of select="total-patients"/></div>
            <div>Total Patients</div>
          </div>
          <div class="stat-card">
            <div class="stat-number"><xsl:value-of select="total-appointments"/></div>
            <div>Appointments</div>
          </div>
          <div class="stat-card">
            <div class="stat-number"><xsl:value-of select="active-patients"/></div>
            <div>Active Patients</div>
          </div>
          <div class="stat-card">
            <div class="stat-number"><xsl:value-of select="substring(last-updated,6)"/></div>
            <div>Last Updated</div>
          </div>
        </xsl:for-each>
      </div>

      <!-- Emergency Alert Example (Dynamic based on conditions) -->
      <xsl:if test="clinic/patients/patient[medical-history/condition = 'Emergency']">
        <div class="emergency-alert">
          ⚠️ EMERGENCY: Patient requires immediate attention!
        </div>
      </xsl:if>

      <!-- Departments Section -->
      <div class="section">
        <h2>🏥 Medical Departments</h2>
        <table>
          <thead>
            <tr>
              <th>Department</th>
              <th>Head</th>
              <th>Location</th>
            </tr>
          </thead>
          <tbody>
            <xsl:for-each select="clinic/departments/department">
              <tr>
                <td>
                  <strong><xsl:value-of select="name"/></strong> 
                  (<xsl:value-of select="@id"/>)
                </td>
                <td><xsl:value-of select="@head"/></td>
                <td><xsl:value-of select="location"/></td>
              </tr>
            </xsl:for-each>
          </tbody>
        </table>
      </div>

      <!-- Patients List -->
      <div class="section">
        <h2>👥 Registered Patients</h2>
        <input type="text" class="search-box" placeholder="🔍 Search patients..." onkeyup="filterPatients(this.value)"/>
        
        <div id="patients-container">
          <xsl:for-each select="clinic/patients/patient">
            <div class="patient-card" data-name="{personal-info/name}" data-id="{@id}">
              <div style="display: flex; justify-content: space-between; align-items: center;">
                <h3 style="margin: 0;">
                  <xsl:value-of select="personal-info/name"/> 
                  <span style="font-size: 14px; color: #666;">(ID: <xsl:value-of select="@id"/>)</span>
                </h3>
                <span class="status-badge status-{translate(current-status,' ','-')}">
                  <xsl:value-of select="current-status"/>
                </span>
              </div>
              
              <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 10px; margin-top: 10px;">
                <div><strong>Age:</strong> <xsl:value-of select="personal-info/age"/></div>
                <div><strong>Gender:</strong> <xsl:value-of select="personal-info/gender"/></div>
                <div><strong>Blood Type:</strong> <span style="background: #ffeb3b; padding: 2px 8px; border-radius: 10px;"><xsl:value-of select="personal-info/blood-type"/></span></div>
                <div><strong>Phone:</strong> <xsl:value-of select="personal-info/contact/phone"/></div>
              </div>
              
              <div style="margin-top: 10px;">
                <strong>Medical History:</strong>
                <ul style="margin: 5px 0;">
                  <xsl:for-each select="medical-history/condition">
                    <li><xsl:value-of select="."/> (since <xsl:value-of select="@date"/>)</li>
                  </xsl:for-each>
                </ul>
              </div>
              
              <div style="margin-top: 10px;">
                <strong>Allergies:</strong>
                <xsl:for-each select="medical-history/allergy">
                  <span class="department-tag" style="background: #ffebee; color: #c62828; margin-right: 5px;">
                    ⚠️ <xsl:value-of select="."/>
                  </span>
                </xsl:for-each>
              </div>
              
              <div style="margin-top: 10px; padding-top: 10px; border-top: 1px dashed #ddd;">
                <strong>Insurance:</strong> <xsl:value-of select="insurance/@provider"/> (Policy: <xsl:value-of select="insurance/@policy-number"/>)
              </div>
            </div>
          </xsl:for-each>
        </div>
      </div>

      <!-- Appointments Schedule -->
      <div class="section">
        <h2>📅 Upcoming Appointments</h2>
        <table>
          <thead>
            <tr>
              <th>ID</th>
              <th>Patient</th>
              <th>Doctor</th>
              <th>Department</th>
              <th>Date & Time</th>
              <th>Status</th>
            </tr>
          </thead>
          <tbody>
            <xsl:for-each select="clinic/appointments/appointment">
              <xsl:sort select="date" order="ascending"/>
              <tr>
                <td><xsl:value-of select="@id"/></td>
                <td>
                  <xsl:variable name="pid" select="patient-id"/>
                  <xsl:for-each select="/clinic/patients/patient[@id=$pid]">
                    <xsl:value-of select="personal-info/name"/>
                  </xsl:for-each>
                </td>
                <td><xsl:value-of select="doctor"/></td>
                <td>
                  <xsl:variable name="deptId" select="department"/>
                  <xsl:for-each select="/clinic/departments/department[@id=$deptId]">
                    <span class="department-tag"><xsl:value-of select="name"/></span>
                  </xsl:for-each>
                </td>
                <td><xsl:value-of select="date"/> at <xsl:value-of select="time"/></td>
                <td>
                  <span class="status-badge status-{translate(status,' ','-')}">
                    <xsl:value-of select="status"/>
                  </span>
                </td>
              </tr>
            </xsl:for-each>
          </tbody>
        </table>
      </div>

      <div class="footer">
        <p>🏥 City Medical Center - Patient Management System v1.0</p>
        <p>📋 This is a demonstration XML application with XSLT transformation</p>
        <p>🔄 Last system update: <xsl:value-of select="clinic/statistics/last-updated"/></p>
      </div>
    </div>

    <!-- JavaScript for interactive features -->
    <script>
      function filterPatients(searchText) {
        let cards = document.querySelectorAll('.patient-card');
        searchText = searchText.toLowerCase();
        
        cards.forEach(card => {
          let name = card.getAttribute('data-name').toLowerCase();
          let id = card.getAttribute('data-id').toLowerCase();
          
          if (name.includes(searchText) || id.includes(searchText)) {
            card.style.display = 'block';
          } else {
            card.style.display = 'none';
          }
        });
      }
      
      // Auto-refresh data every 30 seconds (simulated)
      setInterval(() => {
        console.log('🔄 Refreshing patient data...');
        // In a real app, this would fetch new XML data
      }, 30000);
    </script>
  </body>
  </html>
</xsl:template>

</xsl:stylesheet>