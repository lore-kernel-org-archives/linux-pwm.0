From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: update lpss pwm driver to support Broxton platform
Date: Fri, 12 Jun 2015 12:47:23 +0200
Message-ID: <20150612104722.GJ19400@ulmo.nvidia.com>
References: <1426170508-8273-1-git-send-email-qipeng.zha@intel.com>
 <20150312075835.GC30344@ulmo.nvidia.com>
 <C6287702A945AC47BE5DB5DFD4B5C6DD0185D774@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TA4f0niHM6tHt3xR"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-qk0-f170.google.com ([209.85.220.170]:34348 "EHLO
	mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963AbbFLKsC (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 12 Jun 2015 06:48:02 -0400
Received: by qkhp85 with SMTP id p85so8056401qkh.1
        for <linux-pwm@vger.kernel.org>; Fri, 12 Jun 2015 03:48:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <C6287702A945AC47BE5DB5DFD4B5C6DD0185D774@SHSMSX104.ccr.corp.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: "Zha, Qipeng" <qipeng.zha@intel.com>
Cc: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "Westerberg, Mika" <mika.westerberg@intel.com>


--TA4f0niHM6tHt3xR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Looks like I never got around to applying this. Done now.

Thierry

On Fri, Mar 13, 2015 at 12:51:35AM +0000, Zha, Qipeng wrote:
> Thierry
>=20
> Thank you very much:)
>=20
>=20
> Best wishes
> Qipeng
>=20
> -----Original Message-----
> From: linux-pwm-owner@vger.kernel.org [mailto:linux-pwm-owner@vger.kernel=
=2Eorg] On Behalf Of Thierry Reding
> Sent: Thursday, March 12, 2015 3:59 PM
> To: Zha, Qipeng
> Cc: linux-pwm@vger.kernel.org; Westerberg, Mika
> Subject: Re: [PATCH] pwm: update lpss pwm driver to support Broxton platf=
orm
>=20
> On Thu, Mar 12, 2015 at 10:28:28PM +0800, qipeng.zha wrote:
> > From: "qipeng.zha" <qipeng.zha@intel.com>
> >=20
> > Add pci device id for Broxton platform.
>=20
> For reference, this should be "PCI" and "ID", but I can fix those up whil=
e applying.
>=20
> Also, it's customary to include a changelog in subsequent versions of a p=
atch, as well as change the subject prefix to include the patch version num=
ber. That makes it easier for other people to track things.
>=20
> You can do so using:
>=20
> 	$ git format-patch --subject-prefix=3D'PATCH v2' ...
>=20
> The changelog typically goes below the --- marker (the one below the Sign=
ed-off-by line) and would look something like this:
>=20
> ---
> Changes in v2:
> - keep board information table sorted by device ID
> - reuse Braswell board information
>=20
> Again, no need to resend this time, but something to keep in mind for fut=
ure patches.
>=20
> > Signed-off-by: qipeng.zha <qipeng.zha@intel.com>
>=20
> I'd prefer a proper spelling of your name. Would "Qipeng Zha" be correct?
>=20
> Thierry

--TA4f0niHM6tHt3xR
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVeri6AAoJEN0jrNd/PrOhrn8P/1N5dy0TyQfNi47x5XRYaV6L
16iyHgCem8QGVaI2000Ib9aw8gzsjIwzrJh/Sbz6b8MMzWVImP8uM13QeeqU8Seh
cY3xWP67cfPovFc5k3R0wV9LdpbREKP6FDRgxxx/EPFokKZ7UyYcKEh1dgzfpNk6
Bzss/JG9FHoMwKGLOOyvlCgrZPIErZL+AdR/LbJH9EVUsNXj8ddmSXzRw04HXttC
7bFeyxXrkrtEnOWZD8UZzyKPCuzekuIqiOAFmklzDapz9X+evRIidT1QpEf26AVo
/U9WYx+KpLHBrY4Ew/qz4SZX66Tu53Nzc8sgHvHHQWJC3V/fJaz9RXIHvIq/cbD0
wVu+ntF6Dn4SUjGILUjaVBSh3BcL9JHggiRzCmFs9HXZwlXXKcgxFedECuzOCbPZ
lF8iw3LtWZ6+D3IcNlG5jTNfiW/UlIhSRcH5r5JIBwko2oLLY+ikgcDW0GYsUMnu
4fTGeDsL8xj1BySGmFxLl1Gd0EP30xjxzcbvZ1br5fg1HeVMBSzowE28ap2BsHs/
vmCW3dnH/JKMovyCk+LA1wj5yCeYE3Fcd7rEQt4Pc2457QuuRRErUn3QWVpEXvW7
t7ITTbhDMmnxDrlymCiZ7Q0WG8wFau9FmhP4veB1xz38dTad1HVETC/vsX4NwA7b
NaVlvpp5AG2HKjfAg5Sy
=wDhe
-----END PGP SIGNATURE-----

--TA4f0niHM6tHt3xR--
