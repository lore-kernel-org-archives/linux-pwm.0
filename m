Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:28159 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726626AbfIFRqL (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 6 Sep 2019 13:46:11 -0400
Date: Fri, 6 Sep 2019 20:46:05 +0300
From: "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
Message-ID: <20190906174605.GY2680@smile.fi.intel.com>
References: <cover.1559127603.git.nikolaus.voss@loewensteinmedical.de>
 <8704391ae3004a6b4dd17975dbcc9e88bd28cf4b.1559127603.git.nikolaus.voss@loewensteinmedical.de>
 <20190814185055.GZ30120@smile.fi.intel.com>
 <CF6A88132359CE47947DB4C6E1709ED53C61A211@ORSMSX122.amr.corp.intel.com>
 <alpine.DEB.2.20.1908161345590.41303@fox.voss.local>
 <20190830145348.GM2680@smile.fi.intel.com>
 <alpine.DEB.2.20.1909040913230.15999@fox.voss.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <alpine.DEB.2.20.1909040913230.15999@fox.voss.local>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH 1/3] ACPI: Resolve objects on host-directed table loads
To: Nikolaus Voss <nv@vosn.de>
Cc: "Schmauss, Erik" <erik.schmauss@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>, Thierry Reding <thierry.reding@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>

On Wed, Sep 04, 2019 at 09:20:03AM +0200, Nikolaus Voss wrote:
> On Fri, 30 Aug 2019, Shevchenko, Andriy wrote:
> > On Fri, Aug 16, 2019 at 01:57:26PM +0200, Nikolaus Voss wrote:
> > > On Wed, 14 Aug 2019, Schmauss, Erik wrote:
> > > > > -----Original Message-----
> > > > > From: Shevchenko, Andriy
> > > > > Sent: Wednesday, August 14, 2019 11:51 AM
> > > > > To: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
> > > > > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>; Len Brown <lenb@kernel=
.org>;
> > > > > Moore, Robert <robert.moore@intel.com>; Schmauss, Erik
> > > > > <erik.schmauss@intel.com>; Jacek Anaszewski <jacek.anaszewski@gma=
il.com>;
> > > > > Pavel Machek <pavel@ucw.cz>; Dan Murphy <dmurphy@ti.com>; Thierry
> > > > > Reding <thierry.reding@gmail.com>; linux-acpi@vger.kernel.org;
> > > > > devel@acpica.org; linux-leds@vger.kernel.org; linux-pwm@vger.kern=
el.org
> > > > > Subject: Re: [PATCH 1/3] ACPI: Resolve objects on host-directed t=
able loads
> > > > >=20
> > > > > On Wed, May 29, 2019 at 02:18:20PM +0200, Nikolaus Voss wrote:
> > > > > > If an ACPI SSDT overlay is loaded after built-in tables have be=
en
> > > > > > loaded e.g. via configfs or efivar_ssdt_load() it is necessary =
to
> > > > > > rewalk the namespace to resolve references. Without this, relat=
ive and
> > > > > > absolute paths like ^PCI0.SBUS or \_SB.PCI0.SBUS are not resolv=
ed
> > > > > > correctly.
> > > > > >=20
> > > > > > Make configfs load use the same method as efivar_ssdt_load().
> > > > >=20
> > > > > This patch brought a regression (bisect log below).
> > > > > Now I'm unable to unload the table which was working before.
> > > > >=20
> > > > > Reverting (manual, due to ACPICA changes) helps.
> > > > >=20
> > > > > Please, consider to revert for this cycle, or fix. I will be glad=
 to test any
> > > > > proposed fix.
> > > >=20
> > > > We submitted a patch (d1fb5b2f623b1af5a0d2a83d205df1b61f430dc6)
> > > > in response to this suggestion and I was not aware that this had be=
en applied.
> > > >=20
> > > > Rafael, please revert at least the ACPICA portion of this patch.
> > >=20
> > > As I see it, my ACPICA change is not part of 5.3-rc1 any more. Revert=
ing my
> > > fix is part of the patch above (d1fb5b2f623b1af5a0d2a83d205df1b61f430=
dc6)
> > > which is already applied.
> > >=20
> > > Nevertheless, what is new, is that acpi_ns_initialize_objects() is ca=
lled in
> > > acpi_load_table(). This is necessary to resolve the references in the=
 newly
> > > loaded table. Maybe this prevents the table from being unloaded?
> >=20
> > So, can we do something about it? It's a regression.
> >=20
> > Rafael, Nikolaus?
>=20
> can you describe how you unload the table (from userspace?). I cannot
> reproduce this regression. I was not aware of any working interface for
> unloading ACPI tables, I ended up in kexec'ing the kernel for my tests ea=
ch
> time I had to unload a table.

Sure.

I have connected an I=B2C device(s) to my board where I have compiled ACPI =
tables
which describes them (more details if you want to know is on [1]).

So, I create a folder in ConfigFS [1,2] and fill it up with SSDT (an *.aml =
file).
After this, if I try to remove the folder in ConfigFS followed by table rem=
oval
event, the actual nodes won't be removed, and this messes up with the inter=
nal
representation of the ACPI device tree.

[1]: https://www.kernel.org/doc/html/latest/admin-guide/acpi/ssdt-overlays.=
html
[2]: https://htot.github.io/meta-intel-edison/1.3-ACPI-or-not.html#run-time=
-loading-through-configfs

--=20
With Best Regards,
Andy Shevchenko
