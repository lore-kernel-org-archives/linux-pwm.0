Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lelv0142.ext.ti.com ([198.47.23.249]:39422 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfEaMpt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 31 May 2019 08:45:49 -0400
References: <cover.1559127603.git.nikolaus.voss@loewensteinmedical.de>
 <8704391ae3004a6b4dd17975dbcc9e88bd28cf4b.1559127603.git.nikolaus.voss@loewensteinmedical.de>
 <2944848d-d004-6750-b95d-825b1758ff22@ti.com> <20190531122320.GB3722@amd>
From: Dan Murphy <dmurphy@ti.com>
Message-ID: <422b875b-c450-1aab-f190-ab8388df1dda@ti.com>
Date: Fri, 31 May 2019 07:45:34 -0500
MIME-Version: 1.0
In-Reply-To: <20190531122320.GB3722@amd>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH 1/3] ACPI: Resolve objects on host-directed table loads
To: Pavel Machek <pavel@ucw.cz>
Cc: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, linux-acpi@vger.kernel.org, devel@acpica.org, linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org

Pavel

On 5/31/19 7:23 AM, Pavel Machek wrote:
> Hi!
>
>>> diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfl=
oad.c
>>> index 4f30f06a6f78..61f2d46e52ba 100644
>>> --- a/drivers/acpi/acpica/tbxfload.c
>>> +++ b/drivers/acpi/acpica/tbxfload.c
>>> @@ -297,6 +297,17 @@ acpi_status acpi_load_table(struct acpi_table_head=
er *table)
>>>   	status =3D acpi_tb_install_and_load_table(ACPI_PTR_TO_PHYSADDR(table=
),
>>>   						ACPI_TABLE_ORIGIN_EXTERNAL_VIRTUAL,
>>>   						FALSE, &table_index);
>>> +
>>> +	if (!ACPI_FAILURE(status)) {
>> Checkpatch should complain about putting brackets around single statement
>> if's.
> With multiline statement like that and including comment -- I'd say
> keep {'s. It is cleaner this way.

Maintainers preference.=A0 I won't nack the patch for it.

Not sure their preference as I don't usually submit to acpi.

Dan


> 									Pavel
>
>
