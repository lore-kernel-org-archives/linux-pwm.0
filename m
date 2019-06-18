From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH v2 1/3] ACPI: Resolve objects on host-directed table
 loads
Date: Tue, 18 Jun 2019 19:35:16 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B95FB032@ORSMSX110.amr.corp.intel.com>
References: <cover.1560327219.git.nikolaus.voss@loewensteinmedical.de>
 <e2a4ddfd93a904b50b7ccc074e00e14dc4661963.1560327219.git.nikolaus.voss@loewensteinmedical.de>
 <CAJZ5v0jqxWs=PPik-TCDqQiyxCSyRP7HTue1WsdWP9e-nik2eA@mail.gmail.com>
 <alpine.DEB.2.20.1906141114490.6579@fox.voss.local>
 <94F2FBAB4432B54E8AACC7DFDE6C92E3B95EFB26@ORSMSX110.amr.corp.intel.com>
 <alpine.DEB.2.20.1906170746150.12344@fox.voss.local>
 <94F2FBAB4432B54E8AACC7DFDE6C92E3B95F9EC6@ORSMSX110.amr.corp.intel.com>
 <alpine.DEB.2.20.1906181030240.24846@fox.voss.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.20.1906181030240.24846@fox.voss.local>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Nikolaus Voss <nv@vosn.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "Schmauss, Erik" <erik.schmauss@intel.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>, Thierry Reding <thierry.reding@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, Linux PWM List <linux-pwm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

I'm looking at this. We've changed the initialization of objects in the namespace recently, so I'm checking this out.


> -----Original Message-----
> From: Nikolaus Voss [mailto:nv@vosn.de]
> Sent: Tuesday, June 18, 2019 2:22 AM
> To: Moore, Robert <robert.moore@intel.com>
> Cc: Rafael J. Wysocki <rafael@kernel.org>; Rafael J. Wysocki
> <rjw@rjwysocki.net>; Len Brown <lenb@kernel.org>; Schmauss, Erik
> <erik.schmauss@intel.com>; Jacek Anaszewski
> <jacek.anaszewski@gmail.com>; Pavel Machek <pavel@ucw.cz>; Dan Murphy
> <dmurphy@ti.com>; Thierry Reding <thierry.reding@gmail.com>; ACPI Devel
> Maling List <linux-acpi@vger.kernel.org>; open list:ACPI COMPONENT
> ARCHITECTURE (ACPICA) <devel@acpica.org>; linux-leds@vger.kernel.org;
> Linux PWM List <linux-pwm@vger.kernel.org>; Linux Kernel Mailing List
> <linux-kernel@vger.kernel.org>
> Subject: RE: [PATCH v2 1/3] ACPI: Resolve objects on host-directed table
> loads
> 
> On Mon, 17 Jun 2019, Moore, Robert wrote:
> >> -----Original Message-----
> >> From: Nikolaus Voss [mailto:nv@vosn.de]
> >> Sent: Sunday, June 16, 2019 11:24 PM
> >> To: Moore, Robert <robert.moore@intel.com>
> >> Cc: Rafael J. Wysocki <rafael@kernel.org>; Rafael J. Wysocki
> >> <rjw@rjwysocki.net>; Len Brown <lenb@kernel.org>; Schmauss, Erik
> >> <erik.schmauss@intel.com>; Jacek Anaszewski
> >> <jacek.anaszewski@gmail.com>; Pavel Machek <pavel@ucw.cz>; Dan Murphy
> >> <dmurphy@ti.com>; Thierry Reding <thierry.reding@gmail.com>; ACPI
> >> Devel Maling List <linux-acpi@vger.kernel.org>; open list:ACPI
> >> COMPONENT ARCHITECTURE (ACPICA) <devel@acpica.org>;
> >> linux-leds@vger.kernel.org; Linux PWM List
> >> <linux-pwm@vger.kernel.org>; Linux Kernel Mailing List
> >> <linux-kernel@vger.kernel.org>; nikolaus.voss@loewensteinmedical.de
> >> Subject: RE: [PATCH v2 1/3] ACPI: Resolve objects on host-directed
> >> table loads
> >>
> >> Bob,
> >>
> >> On Fri, 14 Jun 2019, Moore, Robert wrote:
> >>>
> >>>
> >>> -----Original Message-----
> >>> From: Nikolaus Voss [mailto:nv@vosn.de]
> >>> Sent: Friday, June 14, 2019 2:26 AM
> >>> To: Rafael J. Wysocki <rafael@kernel.org>
> >>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>; Len Brown
> >>> <lenb@kernel.org>; Moore, Robert <robert.moore@intel.com>; Schmauss,
> >>> Erik <erik.schmauss@intel.com>; Jacek Anaszewski
> >>> <jacek.anaszewski@gmail.com>; Pavel Machek <pavel@ucw.cz>; Dan
> >>> Murphy <dmurphy@ti.com>; Thierry Reding <thierry.reding@gmail.com>;
> >>> ACPI Devel Maling List <linux-acpi@vger.kernel.org>; open list:ACPI
> >>> COMPONENT ARCHITECTURE (ACPICA) <devel@acpica.org>;
> >>> linux-leds@vger.kernel.org; Linux PWM List
> >>> <linux-pwm@vger.kernel.org>; Linux Kernel Mailing List
> >>> <linux-kernel@vger.kernel.org>
> >>> Subject: Re: [PATCH v2 1/3] ACPI: Resolve objects on host-directed
> >>> table loads
> >>>
> >>> Hi Rafael,
> >>>
> >>> On Fri, 14 Jun 2019, Rafael J. Wysocki wrote:
> >>>> On Wed, Jun 12, 2019 at 10:36 AM Nikolaus Voss
> >>>> <nikolaus.voss@loewensteinmedical.de> wrote:
> >>>>>
> >>>>> If an ACPI SSDT overlay is loaded after built-in tables have been
> >>>>> loaded e.g. via configfs or efivar_ssdt_load() it is necessary to
> >>>>> rewalk the namespace to resolve references. Without this, relative
> >>>>> and absolute paths like ^PCI0.SBUS or \_SB.PCI0.SBUS are not
> >>>>> resolved correctly.
> >>>>>
> >>>>> Make configfs load use the same method as efivar_ssdt_load().
> >>>>>
> >>>>> Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
> >>>>
> >>>> This is fine by me, so
> >>>>
> >>>> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>>
> >>>> Or if you want me to take this patch (without the other two in the
> >>>> series), please let me know.
> >>>
> >>> thanks. I think it would be the best if you take up this patch as it
> >>> is an independent topic. In retrospect it wasn't a good idea to put
> >>> it into this series.
> >>>
> >>> Kind regards,
> >>> Niko
> >>>
> >>> I would have to ask, why is additional code needed for package
> >>> initialization/resolution? It already happens elsewhere in acpica.
> >>> Bob
> >>
> >> for built-in tables loaded via acpi_ex_load_table_op() everything is
> >> fine, because after acpi_tb_load_table() acpi_ns_walk_namespace() is
> >> called to resolve references.
> >>
> >> My fix only affects tables loaded dynamically via either
> >> acpi_configfs driver (for debugging purposes) or efivar_ssdt_load()
> >> (to specify a table on the kernel's command line). They use
> >> acpi_load_table() to load the table from a caller-owned buffer. To
> >> resolve the references, it is again necessary to rewalk the
> >> namespace, which was simply missing in acpi_load_table().
> >>
> > [Moore, Robert]
> >
> > Perhaps you should call AcpiInitializeObjects after the call to
> > AcpiLoadTable, but I will check.
> 
> My usage of acpi_load_table() is to load a SSDT which is the intended
> use of this method according to its description. And my expectation is
> that the package objects of the loaded table are initialized when this
> function successfully returns so it aligns with the behavior of
> acpi_ex_load_table_op() for built-in SSDTs. Otherwise there would be no
> point in having this function at all, because
> acpi_tb_install_and_load_table() could be called directly without any
> difference.
> 
> Niko
