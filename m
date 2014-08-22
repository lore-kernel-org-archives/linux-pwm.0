From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v4 1/2] pwm: lpss: properly split driver to parts
Date: Fri, 22 Aug 2014 13:13:44 +0200
Message-ID: <20140822111343.GA3825@ulmo>
References: <1408465056-8605-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1408465056-8605-2-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-we0-f179.google.com ([74.125.82.179]:43049 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752737AbaHVLNr (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 22 Aug 2014 07:13:47 -0400
Received: by mail-we0-f179.google.com with SMTP id u57so10584829wes.10
        for <linux-pwm@vger.kernel.org>; Fri, 22 Aug 2014 04:13:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1408465056-8605-2-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-pwm@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Alan Cox <alan@linux.intel.com>


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2014 at 07:17:35PM +0300, Andy Shevchenko wrote:
[...]
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
[...]
> +config PWM_LPSS_PCI
> +	tristate "Intel LPSS PWM PCI driver"
> +	depends on PCI
> +	select PWM_LPSS
[...]
> +config PWM_LPSS_PLATFORM
> +	tristate "Intel LPSS PWM platform driver"
> +	depends on ACPI
> +	select PWM_LPSS

I changed both of the above select PWM_LPSS to depends on PWM_LPSS
because that makes them show up in a more meaningful way in menuconfig
and otherwise it looks weird if the PWM_LPSS shows up as automatically
selected without being useful in itself. This way the PWM_LPSS is sort
of a common core that PWM_LPSS_PLATFORM and PWM_LPSS_PCI use.

An alternative that's commonly used for this would be to hide PWM_LPSS
=66rom users and keep the select within PWM_LPSS_PLATFORM and
PWM_LPSS_PCI. That would be okay with me too.

Let me know if you have any objections to this change.

Thierry

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT9yXnAAoJEN0jrNd/PrOhPxcQAK8P1HktqRUlYdlrUpE50Hxq
0U8nAfk3CdbEnI0bW9wUdwj4U4+jhplYbcY7+PppWxLLd/06tDGjZPWhs/KpD3Wx
e8rtkQScMJynDRmWw2lGQ5RWdCUZkCOgBj38mXeDYduBhJz/fA+a5VQ0MhWFf7Su
ZjP5LGZrh7TGcSjAFMvdfVyG4dvGBJybaz+MdhuvCRrWmx/vUnPFTWwiEYc/BO8s
iOHYitDxGOjwBXZ5qMtTRvsHM45VILPixmiPyLWun4iN2zvBKL12OPqFFqhTdKJN
UF3oM0uRg47EIVL5sknHgYYp9eOoC1CKQMFe09Dcju3tq87xcyT6cwIGkw+7vgmY
+ZW+J0Xyra3Ue+C5HW1aSRjGjtxyLpOZZvUnHZ3CUAWIeuqEd0cekQEbkirGxWMd
kewOT7H3tdLP6lJDtL8CKjoVgpF7qdIBknIhgRcJeK9PxA6vqb/JwiXS3ojwpC+9
08dKsAJ9UwRx2FTBdl/YmB/2mqIN04NXBgQ2DgTZjVU+rLCX5g/JPmmeHGZUru0O
zFm4Ff9sEUbUhuX3x1MOExnh6vjGpLSbV7rfAvr6Hi3f2cBGMBhZB2GPA99gv06s
poU9TevQ1P/XPs9NbBewh7MSjMM9s4vWnjan7e56ujOMqaQtBeWYzECrN/4MuEtr
nZ6IDpwbDnjpOGJRbNId
=jnVQ
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
