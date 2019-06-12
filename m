From: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Subject: [PATCH v2 1/3] ACPI: Resolve objects on host-directed table loads
Date: Wed, 12 Jun 2019 10:36:06 +0200
Message-ID: <e2a4ddfd93a904b50b7ccc074e00e14dc4661963.1560327219.git.nikolaus.voss@loewensteinmedical.de>
References: <cover.1560327219.git.nikolaus.voss@loewensteinmedical.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1560327219.git.nikolaus.voss@loewensteinmedical.de>
In-Reply-To: <cover.1560327219.git.nikolaus.voss@loewensteinmedical.de>
References: <cover.1560327219.git.nikolaus.voss@loewensteinmedical.de>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>, linux-acpi@vger.kernel.org, devel@acpica.org, linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, nv@vosn.de
List-Id: linux-pwm@vger.kernel.org

If an ACPI SSDT overlay is loaded after built-in tables
have been loaded e.g. via configfs or efivar_ssdt_load()
it is necessary to rewalk the namespace to resolve
references. Without this, relative and absolute paths
like ^PCI0.SBUS or \_SB.PCI0.SBUS are not resolved
correctly.

Make configfs load use the same method as efivar_ssdt_load().

Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
---
 drivers/acpi/acpi_configfs.c   |  6 +-----
 drivers/acpi/acpica/tbxfload.c | 11 +++++++++++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpi_configfs.c b/drivers/acpi/acpi_configfs.c
index f92033661239..663f0d88f912 100644
--- a/drivers/acpi/acpi_configfs.c
+++ b/drivers/acpi/acpi_configfs.c
@@ -56,11 +56,7 @@ static ssize_t acpi_table_aml_write(struct config_item *cfg,
 	if (!table->header)
 		return -ENOMEM;
 
-	ACPI_INFO(("Host-directed Dynamic ACPI Table Load:"));
-	ret = acpi_tb_install_and_load_table(
-			ACPI_PTR_TO_PHYSADDR(table->header),
-			ACPI_TABLE_ORIGIN_EXTERNAL_VIRTUAL, FALSE,
-			&table->index);
+	ret = acpi_load_table(table->header);
 	if (ret) {
 		kfree(table->header);
 		table->header = NULL;
diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
index 4f30f06a6f78..ef8f8a9f3c9c 100644
--- a/drivers/acpi/acpica/tbxfload.c
+++ b/drivers/acpi/acpica/tbxfload.c
@@ -297,6 +297,17 @@ acpi_status acpi_load_table(struct acpi_table_header *table)
 	status = acpi_tb_install_and_load_table(ACPI_PTR_TO_PHYSADDR(table),
 						ACPI_TABLE_ORIGIN_EXTERNAL_VIRTUAL,
 						FALSE, &table_index);
+
+	if (ACPI_SUCCESS(status)) {
+		/* Complete the initialization/resolution of package objects */
+
+		status = acpi_ns_walk_namespace(ACPI_TYPE_PACKAGE,
+						ACPI_ROOT_OBJECT,
+						ACPI_UINT32_MAX, 0,
+						acpi_ns_init_one_package,
+						NULL, NULL, NULL);
+	}
+
 	return_ACPI_STATUS(status);
 }
 
-- 
2.17.1
