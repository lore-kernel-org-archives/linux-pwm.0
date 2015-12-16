From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v5] pwm:lpss: update pwm setting for Broxton
Date: Wed, 16 Dec 2015 16:47:07 +0100
Message-ID: <20151216154707.GE28947@ulmo>
References: <1447752015-55339-1-git-send-email-qipeng.zha@intel.com>
 <20151117075214.GD1604@lahna.fi.intel.com>
 <C6287702A945AC47BE5DB5DFD4B5C6DD03833AF6@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nHwqXXcoX0o6fKCv"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35119 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965948AbbLPPrK (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Dec 2015 10:47:10 -0500
Received: by mail-wm0-f43.google.com with SMTP id l126so44451857wml.0
        for <linux-pwm@vger.kernel.org>; Wed, 16 Dec 2015 07:47:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <C6287702A945AC47BE5DB5DFD4B5C6DD03833AF6@SHSMSX104.ccr.corp.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: "Zha, Qipeng" <qipeng.zha@intel.com>
Cc: "Westerberg, Mika" <mika.westerberg@intel.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>


--nHwqXXcoX0o6fKCv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 11, 2015 at 06:51:38AM +0000, Zha, Qipeng wrote:
> >> For Broxton PWM controller, base unit is defined as 8bit integer and=
=20
> >> 14bit fraction, so need to update base unit setting to output wave=20
> >> with right frequency.
> >>=20
> >> Signed-off-by: Qipeng Zha <qipeng.zha@intel.com>
>=20
> >My ack still applies to this patch.
>  Hi Thierry, are you going to apply this patch, thanks.

I've applied this. Next time if somebody gives you an Acked-by, please
include it in the commit message if you send another version. That makes
life a little easier for me.

Thierry

--nHwqXXcoX0o6fKCv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWcYd7AAoJEN0jrNd/PrOh7PYP/ir52D+vQdi9oBx4ztdlnbfn
OZKL5Lgh1IFCXydve5f22zP213BH79bo2mXOm2TTwXeo1uiTCAZuFDmmiqUa1532
Ke0C7Z1K/CraaqvPnvKcYTQxltj+zie/vNi04WEkZ2ynolfTfLS4SeRWo1c8RrxR
3QppWWPg3UokSKq3ZFTLfPjv7qTD7FCHDzrgoA7ejbVfIzhPpCOPib07hGutrpoP
c2dRRLLnQ8TJqf0n1hAqH/sNQZ6agPakISAZk0f2/FRPajpoWTQXWelMguZjuwr6
UcTt9VVOoh99g84XbH5r8B7Je28LYmLoOsH7wQ+DkT54iPE/yZxkXew1SDTTa5uP
ZzKwbPMcFDpr2ERhtLHqDSUlGd/WWzLERnXPYxOSidXhKqZl/3jYkaNT6PmC3IQe
AKirA6wPtCnXm7qrtf+Je+xX0LuYsvkop0Mr8E6hCOUedgIrEshFSdPX4TZ3xatY
lUr49RBLLn/Gg20LOmqPl/+lQJiMZd3gYelgDBPem+ifmKGNpT6OxLusmDL2r9W8
6Xau2NaeImNdJz6RgMGFLI09wRqFFCtYtXZrJzTjWNGCpU/iDwGpTx93OXOYyV/2
4O2Cr9rp23z1f4Ma1t2OdpOcVm+jbTYb+7le0eP/eISBCZnmTXWmAk0EnsjbQ36w
x2Q+B5MdJ0ANXpnur+G3
=jpKI
-----END PGP SIGNATURE-----

--nHwqXXcoX0o6fKCv--
