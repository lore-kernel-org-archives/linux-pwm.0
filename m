From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH v2 1/3] ACPI: Resolve objects on host-directed table
 loads
Date: Tue, 18 Jun 2019 20:31:52 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B95FB0BA@ORSMSX110.amr.corp.intel.com>
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
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Nikolaus Voss <nv@vosn.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "Schmauss, Erik" <erik.schmauss@intel.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>, Thierry Reding <thierry.reding@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, Linux PWM List <linux-pwm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org



> -----Original Message-----
> From: Moore, Robert
> Sent: Tuesday, June 18, 2019 1:25 PM
> To: 'Nikolaus Voss' <nv@vosn.de>
> Cc: 'Rafael J. Wysocki' <rafael@kernel.org>; 'Rafael J. Wysocki'
> <rjw@rjwysocki.net>; 'Len Brown' <lenb@kernel.org>; Schmauss, Erik
> <erik.schmauss@intel.com>; 'Jacek Anaszewski'
> <jacek.anaszewski@gmail.com>; 'Pavel Machek' <pavel@ucw.cz>; 'Dan
> Murphy' <dmurphy@ti.com>; 'Thierry Reding' <thierry.reding@gmail.com>;
> 'ACPI Devel Maling List' <linux-acpi@vger.kernel.org>; 'open list:ACPI
> COMPONENT ARCHITECTURE (ACPICA)' <devel@acpica.org>; 'linux-
> leds@vger.kernel.org' <linux-leds@vger.kernel.org>; 'Linux PWM List'
> <linux-pwm@vger.kernel.org>; 'Linux Kernel Mailing List' <linux-
> kernel@vger.kernel.org>
> Subject: RE: [PATCH v2 1/3] ACPI: Resolve objects on host-directed table
> loads
> 
> If it is in fact the AcpiLoadTable interface that is incorrect, that of
> course is different. I'll check that out next.
> 
[Moore, Robert] 

Yes, this is the issue, not specifically the Load() operator, but the AcpiLoadTable interface only.

> 
> > -----Original Message-----
> > From: Moore, Robert
> > Sent: Tuesday, June 18, 2019 1:23 PM
> > To: 'Nikolaus Voss' <nv@vosn.de>
> > Cc: 'Rafael J. Wysocki' <rafael@kernel.org>; 'Rafael J. Wysocki'
> > <rjw@rjwysocki.net>; 'Len Brown' <lenb@kernel.org>; Schmauss, Erik
> > <erik.schmauss@intel.com>; 'Jacek Anaszewski'
> > <jacek.anaszewski@gmail.com>; 'Pavel Machek' <pavel@ucw.cz>; 'Dan
> > Murphy' <dmurphy@ti.com>; 'Thierry Reding' <thierry.reding@gmail.com>;
> > 'ACPI Devel Maling List' <linux-acpi@vger.kernel.org>; 'open list:ACPI
> > COMPONENT ARCHITECTURE (ACPICA)' <devel@acpica.org>; 'linux-
> > leds@vger.kernel.org' <linux-leds@vger.kernel.org>; 'Linux PWM List'
> > <linux-pwm@vger.kernel.org>; 'Linux Kernel Mailing List' <linux-
> > kernel@vger.kernel.org>
> > Subject: RE: [PATCH v2 1/3] ACPI: Resolve objects on host-directed
> > table loads
> >
> > It looks to me that the package objects are being initialized properly
> > already, unless I'm missing something. Please check the examples below
> > and in the attached files.
> >
> > Attached is a small test case that dynamically loads an SSDT which
> > contains a package object which in turn contains references to other
> > objects.
> >
> >
> > Main DSDT:
> >     Method (LD1)
> >     {
> >         Load (BUF1, HNDL)      // SSDT is in BUF1
> >         Store (HNDL, Debug)
> >         Return
> >     }
> >
> > Loaded table:
> >     External (DEV1, DeviceObj)
> >     Name (PKG1, Package() {
> >         1,2, DEV2, DEV1, 4})
> >     Device (DEV2) {}
> >
> >
> > AcpiExec Output:
> > - ev ld1
> > Evaluating \LD1
> > ACPI: Dynamic OEM Table Load:
> > ACPI: SSDT 0x00000000006DEEB8 000051 (v02 Intel  Load     00000001
> INTL
> > 20190509)
> > ACPI Exec: Table Event INSTALL, [SSDT] 006DEEB8
> > Table [SSDT: Load    ] (id 06) -    5 Objects with   1 Devices,   0
> > Regions,    1 Methods
> > ACPI Exec: Table Event LOAD, [SSDT] 006DEEB8 ACPI Debug:  Reference
> > [DdbHandle] Table Index 0x3
> > 0x7 Outstanding allocations after evaluation of \LD1 Evaluation of
> > \LD1 returned object 006D2FE8, external buffer length 18
> >   [Integer] = 0000000000000000
> >
> > - ev pkg1
> > Evaluating \PKG1
> > Evaluation of \PKG1 returned object 006D2FE8, external buffer length
> 90
> >   [Package] Contains 5 Elements:
> >     [Integer] = 0000000000000001
> >     [Integer] = 0000000000000002
> >     [Object Reference] = 006DDF88 <Node>            Name DEV2 Device
> >     [Object Reference] = 006DD608 <Node>            Name DEV1 Device
> >     [Integer] = 0000000000000004
