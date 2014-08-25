From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: imx: don't reprogram PWMSAR if PWM is disabled
Date: Mon, 25 Aug 2014 15:56:53 +0200
Message-ID: <20140825135652.GL4163@ulmo.nvidia.com>
References: <1406102987-14797-1-git-send-email-dbaryshkov@gmail.com>
 <CALT56yON=icaJZa22F30caYOGVLiHqBdXX2sfHqTBArd+PxrFA@mail.gmail.com>
 <20140805013627.GB27051@dragon>
 <53E09A69.5000806@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZrCu0B0FMx3UnjE2"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:62680 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755489AbaHYN46 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 25 Aug 2014 09:56:58 -0400
Received: by mail-pa0-f43.google.com with SMTP id lf10so21213650pab.30
        for <linux-pwm@vger.kernel.org>; Mon, 25 Aug 2014 06:56:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <53E09A69.5000806@freescale.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Dmitry Eremin-Solenikov <dmitry_eremin@mentor.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, Liu Ying <Ying.Liu@freescale.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-pwm@vger.kernel.org


--ZrCu0B0FMx3UnjE2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 05, 2014 at 04:48:41PM +0800, Liu Ying wrote:
> On 08/05/2014 09:36 AM, Shawn Guo wrote:
> >On Fri, Aug 01, 2014 at 10:02:17PM +0400, Dmitry Eremin-Solenikov wrote:
> >>On Wed, Jul 23, 2014 at 12:09 PM, Dmitry Eremin-Solenikov
> >><dbaryshkov@gmail.com> wrote:
> >>>From: Dmitry Eremin-Solenikov <dmitry_eremin@mentor.com>
> >>>
> >>>Writing several values to PWMSAR register with PWM being disabled can
> >>>lead to FIFO (connected to PWMSAR) being overflown. Then after enabling
> >>>PWM, hardware will use stale values. Instead cache the duty cycles and
> >>>write them to the hardware only before enabling PWM.
> >>
> >>What about this patch?
> >
> >Copy Liu Ying who seems to have a patch [1] addressing the same problem?
> >
>=20
> Yes, my patch may address the same problem. And, my patch may cache the l=
ast
> duty cycle as well when the PWM is disabled. The difference is that my pa=
tch
> caches it in the register PWMSAR instead of a variable.

Dmitry,

I've just pushed Liu's patch that might fix this problem. Can you give
it a quick spin to see if it fixes the issue that you're seeing? It's in
the for-next branch of the PWM tree[0].

Thanks,
Thierry

[0]: git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm=
=2Egit

--ZrCu0B0FMx3UnjE2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT+0CkAAoJEN0jrNd/PrOhiRkP/iDsxzQSD3JNHuu5VZWaLFD6
OwPGyhifK3qxkpJzgU7imQZ9ZSoZO+hSWqPoV7iVl6yYoil3f6md6hfEjVOsxDDO
tDN8GmdoqQdVoRbtjG1SN1f2TCIdbk5MjgbbS+487VEOQtjjtmPcPVdCCWUpezJj
vFegNDPoHiZMKZMN+bB2qtsFQlvK3bsakjPuJ1jBxftA6IFiwyigU5dLoBXEPfC/
Go1uo48rF+vH9TptVeahTPZn/GY6cSnEPHWX2VWfzcSKiIwc6t8RIt+F/9K98HgW
VvLLrnMsuFcIi/CrK9Efo9+/KmO7IhP7mqd/ZVWnqKihzLlbWL1CvT9w/6Ol1iTP
XOfkgL0k+zuDyzKYw0e8nXaCvtFqaRLeWMMM8NLGwjH007lIMq+MfX+Xd9Rw7/nO
F8xtAwRUx00eeyvQxoL4Kn0YskYXnAW3mCOYj7p7lYjdocNv3Je++I37Ij3mM50E
pGssXk+/Z7mqcd7Il/kJMPIafyiF3+IX1ie7ZYAr/zckWLmcX/JdF4eAKpim0tJl
QEaSi4NEvF1gsON4MCzj+hTpL9rxWxqVb1SQfVVYF8iPL8oJEKka6WZ7cfDZzHPE
vOVy9p6Hs4DMUnYmBkcyY+cCSFzZcNBqp6jrsZmblvTjFtLE5lzIMcN0solKDHWH
5ago2JFbCOmggvBZVOJw
=Xkyg
-----END PGP SIGNATURE-----

--ZrCu0B0FMx3UnjE2--
