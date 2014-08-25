From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v4 1/2] pwm: lpss: properly split driver to parts
Date: Mon, 25 Aug 2014 11:28:57 +0200
Message-ID: <20140825092856.GA2399@ulmo>
References: <1408465056-8605-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1408465056-8605-2-git-send-email-andriy.shevchenko@linux.intel.com>
 <20140822111343.GA3825@ulmo>
 <1408954277.30155.0.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:45929 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751127AbaHYJ3A (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 25 Aug 2014 05:29:00 -0400
Received: by mail-wi0-f181.google.com with SMTP id bs8so2219223wib.14
        for <linux-pwm@vger.kernel.org>; Mon, 25 Aug 2014 02:28:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1408954277.30155.0.camel@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-pwm@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Alan Cox <alan@linux.intel.com>


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2014 at 11:11:17AM +0300, Andy Shevchenko wrote:
> On Fri, 2014-08-22 at 13:13 +0200, Thierry Reding wrote:
> > On Tue, Aug 19, 2014 at 07:17:35PM +0300, Andy Shevchenko wrote:
> > [...]
> > > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > [...]
> > > +config PWM_LPSS_PCI
> > > +	tristate "Intel LPSS PWM PCI driver"
> > > +	depends on PCI
> > > +	select PWM_LPSS
> > [...]
> > > +config PWM_LPSS_PLATFORM
> > > +	tristate "Intel LPSS PWM platform driver"
> > > +	depends on ACPI
> > > +	select PWM_LPSS
> >=20
> > I changed both of the above select PWM_LPSS to depends on PWM_LPSS
> > because that makes them show up in a more meaningful way in menuconfig
> > and otherwise it looks weird if the PWM_LPSS shows up as automatically
> > selected without being useful in itself. This way the PWM_LPSS is sort
> > of a common core that PWM_LPSS_PLATFORM and PWM_LPSS_PCI use.
> >=20
> > An alternative that's commonly used for this would be to hide PWM_LPSS
> > from users and keep the select within PWM_LPSS_PLATFORM and
> > PWM_LPSS_PCI. That would be okay with me too.
> >=20
> > Let me know if you have any objections to this change.
>=20
>=20
> Didn't notice your message before.
> Regarding to this one I think the way to hide PWM_LPSS from user would
> be preferred, though I'm okay if it keeps visible.
>=20
> In addition to compile error you get from Stephen, thanks for quick fix,
> though I think we have to make PWM_LPSS dependent to X86 for now. I
> don't believe we will have same IP on other architectures.

I does seem to build fine for other architectures, so I'm fine with
keeping it available for non-x86. But I don't have a strong opinion
either way, so if you'd rather make it x86-specific, feel free to
send a patch.

Thierry

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT+wHYAAoJEN0jrNd/PrOh3woQAIlSvZxkiHYaDtYoaqHOwlxv
WgP0dFgzcAPHOGF/0iiJBWwuOMma7zXNtmSyTUS7fw0srX0hvHGXPGWGh5Duq5sH
mOdHDCxOr0gPUZ6dFGE4N3PdYZtWByIHbQd1S6meoBK5VD3g4XAXYt/Lr9QJQ9Nk
7DONqjVxOH6NiPD8EtE8k333ZP75WydiFkdr1axou94hdROBB2BOxIdWa2xuj6RP
vOBlRCchPZKMnd5XetKHwDjCc2Qw02Xbwi+STHYUCvY6q30QG2uHuEi/p+/lkslM
kKGAgoovgnYjjoec2a5Q2iHPMnKVHc8y7D+Oaszl1Esh3FH4mHwWDRQPYmcn2rNa
A1XNShz0HSaqw5GHh98fdbMXDgdq29CYCj3FLKACnndcIhzdrgfdWxqr/idbx1lF
PHVNsbdy031kVCX41oM6rA9L4LoyfuH2q2/NfK9gZFEGE+AYmDRtTaLdbdx23uKc
x6tPA8NNjqoIG7PF5qB/FvX1GTOiI1VGMDvAv3ZzCCm2r8Cxkxv45Fxm5/GGlo06
aPWOK0Mk1xES2BT3md+1HZ++0MLCIhHDKR9IqRpQgeuXxOLfcn257UKYVByW6J60
B5ebVgMQAR9GlNk8rcclwzczJVifTblwvxwhGnc5/kHGJ86FCd+KHqao5wRRMI7w
MWCRqbABD8Zyyeym0GRP
=3sBI
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
