Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34024 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727503AbfE3Omv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 30 May 2019 10:42:51 -0400
References: <cover.1559127603.git.nikolaus.voss@loewensteinmedical.de>
 <8704391ae3004a6b4dd17975dbcc9e88bd28cf4b.1559127603.git.nikolaus.voss@loewensteinmedical.de>
From: Dan Murphy <dmurphy@ti.com>
Message-ID: <2944848d-d004-6750-b95d-825b1758ff22@ti.com>
Date: Thu, 30 May 2019 09:42:27 -0500
MIME-Version: 1.0
In-Reply-To: <8704391ae3004a6b4dd17975dbcc9e88bd28cf4b.1559127603.git.nikolaus.voss@loewensteinmedical.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH 1/3] ACPI: Resolve objects on host-directed table loads
To: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org, linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org

Nikolaus

On 5/29/19 7:18 AM, Nikolaus Voss wrote:
> If an ACPI SSDT overlay is loaded after built-in tables
> have been loaded e.g. via configfs or efivar_ssdt_load()
> it is necessary to rewalk the namespace to resolve
> references. Without this, relative and absolute paths
> like ^PCI0.SBUS or \_SB.PCI0.SBUS are not resolved
> correctly.
>
> Make configfs load use the same method as efivar_ssdt_load().
>
> Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
> ---
>   drivers/acpi/acpi_configfs.c   |  6 +-----
>   drivers/acpi/acpica/tbxfload.c | 11 +++++++++++
>   2 files changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/acpi/acpi_configfs.c b/drivers/acpi/acpi_configfs.c
> index f92033661239..663f0d88f912 100644
> --- a/drivers/acpi/acpi_configfs.c
> +++ b/drivers/acpi/acpi_configfs.c
> @@ -56,11 +56,7 @@ static ssize_t acpi_table_aml_write(struct config_item *cfg,
>   	if (!table->header)
>   		return -ENOMEM;
>   
> -	ACPI_INFO(("Host-directed Dynamic ACPI Table Load:"));
> -	ret = acpi_tb_install_and_load_table(
> -			ACPI_PTR_TO_PHYSADDR(table->header),
> -			ACPI_TABLE_ORIGIN_EXTERNAL_VIRTUAL, FALSE,
> -			&table->index);
> +	ret = acpi_load_table(table->header);
>   	if (ret) {
>   		kfree(table->header);
>   		table->header = NULL;
> diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
> index 4f30f06a6f78..61f2d46e52ba 100644
> --- a/drivers/acpi/acpica/tbxfload.c
> +++ b/drivers/acpi/acpica/tbxfload.c
> @@ -297,6 +297,17 @@ acpi_status acpi_load_table(struct acpi_table_header *table)
>   	status = acpi_tb_install_and_load_table(ACPI_PTR_TO_PHYSADDR(table),
>   						ACPI_TABLE_ORIGIN_EXTERNAL_VIRTUAL,
>   						FALSE, &table_index);
> +
> +	if (!ACPI_FAILURE(status)) {
Checkpatch should complain about putting brackets around single 
statement if's.
> +		/* Complete the initialization/resolution of package objects */
> +

Extra new lines


Dan

> +		status = acpi_ns_walk_namespace(ACPI_TYPE_PACKAGE,
> +						ACPI_ROOT_OBJECT,
> +						ACPI_UINT32_MAX, 0,
> +						acpi_ns_init_one_package,
> +						NULL, NULL, NULL);
> +	}
> +
>   	return_ACPI_STATUS(status);
>   }
>   
