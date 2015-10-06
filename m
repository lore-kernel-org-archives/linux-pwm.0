From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v4 4/4] misc: atmel_tclib: get and use slow clock
Date: Tue, 6 Oct 2015 09:33:23 +0200
Message-ID: <20151006073323.GA18633@ulmo>
References: <1439717026-30634-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1439717026-30634-5-git-send-email-alexandre.belloni@free-electrons.com>
 <20151005152706.GC17612@ulmo>
 <20151005165816.GI2694@piout.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:35769 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751811AbbJFHd0 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 6 Oct 2015 03:33:26 -0400
Content-Disposition: inline
In-Reply-To: <20151005165816.GI2694@piout.net>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pwm@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 05, 2015 at 06:58:16PM +0200, Alexandre Belloni wrote:
> On 05/10/2015 at 17:27:06 +0200, Thierry Reding wrote :
> > On Sun, Aug 16, 2015 at 11:23:46AM +0200, Alexandre Belloni wrote:
> > > From: Boris Brezillon <boris.brezillon@free-electrons.com>
> > >=20
> > > Commit dca1a4b5ff6e ("clk: at91: keep slow clk enabled to prevent sys=
tem
> > > hang") added a workaround for the slow clock as it is not properly ha=
ndled
> > > by its users.
> > >=20
> > > Get and use the slow clock as it is necessary for the timer counters.
> > >=20
> > > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.co=
m>
> > > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > > Cc: Thierry Reding <thierry.reding@gmail.com>
> > > Cc: linux-pwm@vger.kernel.org
> > >  drivers/clocksource/tcb_clksrc.c | 10 +++++++++-
> > >  drivers/misc/atmel_tclib.c       |  4 ++++
> > >  drivers/pwm/pwm-atmel-tcb.c      | 26 +++++++++++++++++++-------
> > >  include/linux/atmel_tc.h         |  1 +
> > >  4 files changed, 33 insertions(+), 8 deletions(-)
> >=20
> > This doesn't seem to apply anymore. Does it need to be rebased? Or do I
> > need some other patch as a dependency?
> >=20
>=20
> It will apply cleanly after [PATCH v4 3/4] clocksource: tcb_clksrc: fix
> setup_clkevents error path
>=20
> It already has Daniel's ack so you can also take it if you want. Else,
> we can take it through at91.

Might be best to take it all into the at91 tree, so:

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWE3lAAAoJEN0jrNd/PrOhmXkQAKz8YoJT2ZOqLxVRnHbf+H96
wC2dbs68WfDiP/RgeChCIHwdIDs+qAuijxV5WyIVRAII633use9M0L45LDIFuqxt
yw4lbPazgxMmN7EK7mKpMkobkui0chM8ACZWUuY1g/0NJawqfxOsC0R6ns2V2/cu
hAZpdCoJfkY0bSGRyPsSstRdZ0L3ImMVGreZWCuXmMxyWAXskAdo+bUYQ29jVRub
0lF5/ntM9HfEl+GlB0L3kSLWkohxRsxij0EBwl2C8UeXcTUzDT0JK2/pRV+eCEtK
9J3mJ6DTghMefiAo59CiW2B9q1+zD/qIiMPWXdC70Lke0Pq5DxCbk4tYTj6EyTRs
08aF97ejXhoOy250eZVib0eqmbRuI+Ukite/ZR3wcqja/xDg9bMZxjvWnMOzvvM7
Fkg21asjUeIzU6ewbxzbokMziR8CJMmteyYDRLRe9XuaaumGua9ehnFKbUyCbYmF
qHFHBz3ZY9uqheUE7Z+xp5Ls5ipTwl8gmnaPPGPy4w4meBJmY0eY+Izjj+HI+OsS
7pk3maCpc2O9mytts0UUqj35ypNn9a4/kT70LVgivCdtmwgAmpXiKymiYth+A8cf
hVIEZMiNqPugE5psEss/Cw0/VNGf6+s2lxwufy8rVq/zkNpgh33ZYF4n2Z2hq417
mUmLRYtcfVqHkxc3CFa4
=rDcX
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
