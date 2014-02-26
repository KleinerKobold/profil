<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format"
	xmlns:pr="http://www.example.org/Profile">
	<xsl:output method="xml" indent="yes" />

	<!-- Possible Fonts: 	Helvetica Helvetica, sans-serif, SansSerif 
							Times Times, Times Roman, Times-Roman, serif, any 
							Courier Courier, monospace, Monospaced 
							Symbol Symbol ZapfDingbats ZapfDingbats -->


	<xsl:variable name="SpaceAfterSection" select="'25pt'" />
	<xsl:variable name="SpaceAfterParagraph" select="'20pt'" />
	<xsl:variable name="SpaceAfterHeadline" select="'10pt'" />
	<xsl:variable name="SpaceAfterSmall" select="'8pt'" />
	<xsl:variable name="DefaultFontSize" select="'8pt'" />
	<xsl:variable name="DefaultFontFamily" select="'Helvetica'" />
	
	<xsl:variable name="Section_Color" select="'blue'" />
	<xsl:variable name="Section_FontSize" select="'12pt'" />


	<xsl:template match="/">
		<fo:root>
			<fo:layout-master-set>

				<fo:simple-page-master master-name="A4-portrait"
					page-height="29.7cm" page-width="21.0cm" margin="2cm">
					<fo:region-body margin-top="1cm" margin-bottom="2cm"
						region-name="xsl-region-body" />
					<fo:region-before extent="0cm" region-name="before" />
					<fo:region-after region-name="after" />
				</fo:simple-page-master>

				<fo:page-sequence-master master-name="global">
					<fo:repeatable-page-master-alternatives>
						<fo:conditional-page-master-reference
							master-reference="A4-portrait" page-position="first" />
						<fo:conditional-page-master-reference
							master-reference="A4-portrait" page-position="rest" />
						<!-- default -->
						<fo:conditional-page-master-reference
							master-reference="A4-portrait" />
					</fo:repeatable-page-master-alternatives>
				</fo:page-sequence-master>

			</fo:layout-master-set>


			<fo:page-sequence master-reference="A4-portrait">
				<fo:static-content flow-name="after">
					<fo:block text-align="center" font-size="8pt">
						E-Mail:
						<xsl:value-of select="pr:Profile/pr:Contact/pr:EMail" />
						<xsl:if test="pr:Profile/pr:Contact/pr:Fone">
						| Telefon:
						<xsl:value-of select="pr:Profile/pr:Contact/pr:Fone" />
						</xsl:if>
					</fo:block>
				</fo:static-content>
				
				
				<fo:flow flow-name="xsl-region-body" font-size="{$DefaultFontSize}"
					font-family="{$DefaultFontFamily}">
					<fo:block font-size="18pt" color="{$Section_Color}">
						Profil von
						<xsl:value-of select="pr:Profile/pr:Name" />
					</fo:block>
					<xsl:if test="pr:Profile/pr:Contact/pr:Address">
					<fo:block><xsl:value-of select="pr:Profile/pr:Contact/pr:Address/pr:Street" /></fo:block>
					<fo:block><xsl:value-of select="pr:Profile/pr:Contact/pr:Address/pr:Zip" /><xsl:value-of select="pr:Profile/pr:Contact/pr:Address/pr:City" /></fo:block>
					</xsl:if>
					<xsl:if test="pr:Profile/pr:Contact/pr:EMail"><fo:block>
						E-Mail:
						<xsl:value-of select="pr:Profile/pr:Contact/pr:EMail" />
					</fo:block>
					</xsl:if> 
					<xsl:if test="pr:Profile/pr:Contact/pr:Fone">
					<fo:block >
						Telefon:
						<xsl:value-of select="pr:Profile/pr:Contact/pr:Fone" />
					</fo:block>
					</xsl:if>
					<xsl:apply-templates />
				</fo:flow>

			</fo:page-sequence>
		</fo:root>
	</xsl:template>

	<!-- Übersicht -->
	<xsl:template match="/pr:Profile/pr:Experiences">
		<fo:block color="{$Section_Color}" text-decoration="underline"
			font-weight="bold" font-size="{$Section_FontSize}" space-before="{$SpaceAfterSection}">Berufliche Erfahrungen:</fo:block>

		<xsl:for-each select="pr:Experience">

			<fo:block space-before="{$SpaceAfterHeadline}">
				<fo:inline font-weight="bold">
					<xsl:value-of select="@Name" />
				</fo:inline>
				<xsl:if test="@start">
					von
					<xsl:value-of select="@start" />
				</xsl:if>
				<xsl:if test="@end">
					bis
					<xsl:value-of select="@end" />
				</xsl:if>
			</fo:block>

			<fo:block text-align="center">
				<fo:leader leader-pattern="rule" leader-length="99%"
					rule-style="solid" rule-thickness="0.5pt" />
			</fo:block>

			<fo:block text-indent="20pt">

				<xsl:if test="pr:Employee/@Name">
					<fo:block>
						bei
						<xsl:value-of select="pr:Employee/@Name" />
					</fo:block>
				</xsl:if>

				<xsl:for-each select="pr:Project">
					<fo:block space-before="{$SpaceAfterSmall}">
						<fo:inline font-weight="bold">
							Projekt
							<xsl:choose>
								<xsl:when test="./pr:Customer">
									als externer Berater:
								</xsl:when>
								<xsl:when test="./pr:InternalProject">
									intern:
								</xsl:when>
							</xsl:choose>
						</fo:inline>

						<xsl:value-of select="./@Name" />
					</fo:block>
					<fo:block text-indent="40pt">
						<xsl:for-each select="pr:Role">
							<fo:block>
								Eingesetzt als
								<xsl:value-of select="./@Name" />
							</fo:block>
						</xsl:for-each>
					</fo:block>
				</xsl:for-each>

			</fo:block>
		</xsl:for-each>
	</xsl:template>


	<xsl:template match="/pr:Profile/pr:Education">
		<fo:block color="{$Section_Color}" text-decoration="underline"
			font-weight="bold" font-size="{$Section_FontSize}" space-before="{$SpaceAfterParagraph}">Ausbildung:
		</fo:block>
		<xsl:for-each select="pr:Education">

			<fo:block font-weight="bold" space-before="{$SpaceAfterHeadline}">
				<xsl:value-of select="./@Name" />
			</fo:block>
			<fo:block text-align="center">
				<fo:leader leader-pattern="rule" leader-length="99%"
					rule-style="solid" rule-thickness="0.5pt" />
			</fo:block>
			<fo:block>
				<fo:block text-indent="20pt">
				<fo:block>
					von
					<xsl:value-of select="./@Start" />
					bis
					<xsl:value-of select="./@End" />
					<xsl:choose>
						<xsl:when test="./@Graduated">
							mit Abschluss als
							<xsl:value-of select="./@Degree"></xsl:value-of>
						</xsl:when>
						<xsl:otherwise>
							ohne Abschluss
						</xsl:otherwise>
					</xsl:choose>
				</fo:block>
				
				<fo:block>
					Fächer:
				</fo:block>
				<fo:list-block text-indent="40pt">
					<xsl:for-each select="./pr:FieldOfStudy">
						<fo:list-item>
							<fo:list-item-label>
								<fo:block></fo:block>
							</fo:list-item-label>
							<fo:list-item-body>
								<fo:block>
									<xsl:value-of select="./pr:Name" />
									<xsl:if test="./pr:Specialization">
										- <xsl:value-of select="./pr:Specialization" />
									</xsl:if>
								</fo:block>
							</fo:list-item-body>
						</fo:list-item>
					</xsl:for-each>
				</fo:list-block>
			</fo:block>
			</fo:block>
		</xsl:for-each>

	</xsl:template>
	
	
	<xsl:template match="/pr:Profile/pr:Qualifications">
		<fo:block color="{$Section_Color}" text-decoration="underline"
			font-weight="bold" font-size="{$Section_FontSize}" space-before="{$SpaceAfterParagraph}" space-after="{$SpaceAfterHeadline}">Qualifikationen:
		</fo:block>
		<fo:list-block text-indent="40pt">
		<xsl:for-each select="pr:Qualification">
		<fo:list-item>
			<fo:list-item-label>
				<fo:block></fo:block>
			</fo:list-item-label>
			<fo:list-item-body>
				<fo:block>
					<xsl:value-of select="./@Name" />
				</fo:block>
			</fo:list-item-body>
			</fo:list-item>
		</xsl:for-each>
		</fo:list-block>
	</xsl:template>

	<xsl:template match="/pr:Profile/pr:Languages">
		<fo:block color="{$Section_Color}" text-decoration="underline"
			font-weight="bold" font-size="{$Section_FontSize}" space-before="{$SpaceAfterParagraph}" space-after="{$SpaceAfterHeadline}">Sprachen:
		</fo:block>
		<fo:list-block text-indent="40pt">
		<xsl:for-each select="pr:Language">
		<fo:list-item>
			<fo:list-item-label>
				<fo:block></fo:block>
			</fo:list-item-label>
			<fo:list-item-body>
				<fo:block>
					<xsl:value-of select="./@Name" /> <xsl:if test="./@Level"> - <xsl:choose>
					<xsl:when test="./@Level='First Language'">Muttersprache</xsl:when>
					<xsl:when test="./@Level='Fluent'">Verhandlungssicher</xsl:when>
					<xsl:when test="./@Level='Good Knowledge'">Gute Kenntnisse</xsl:when>
					<xsl:when test="./@Level='Basic Knowledge'">Grundlagen</xsl:when>
					</xsl:choose> </xsl:if>
				</fo:block>
			</fo:list-item-body>
			</fo:list-item>
		</xsl:for-each>
		</fo:list-block>
	</xsl:template>


</xsl:stylesheet>

