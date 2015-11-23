From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH RESEND] pwm: ftm: fix clock enable/disable when using PM
Date: Mon, 23 Nov 2015 10:45:50 +0100
Message-ID: <20151123094550.GA28740@ulmo.nvidia.com>
References: <1445142552-3530-1-git-send-email-stefan@agner.ch>
 <290ed017061ef41e1fe5c3fd5a523511@agner.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34873 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752727AbbKWJpz (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 23 Nov 2015 04:45:55 -0500
Content-Disposition: inline
In-Reply-To: <290ed017061ef41e1fe5c3fd5a523511@agner.ch>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2015 at 06:04:12PM -0800, Stefan Agner wrote:
> Thierry,
>=20
> I realized that this patch did not make it into 4.4-rc1, while others,
> IMHO less important patches which have been posted later (e.g. sunxi
> whitespace fixes) have made it! :-(

The reason why I merged them is because they are low-risk, whereas this
patch of yours changes existing behaviour, and hasn't received any
feedback from anyone. So the choice that I need to make is to either
trust the original author to have tested the driver and it was working,
or you to have verified that it is still working after the patch on all
setups that it used to work on. The first option obviously carries the
least risk, and that's the reason why the patch hasn't been merged.

> Anything wrong with that? Or am I on your spam list? Note that this is
> already a RESEND :-)

If you want to get this merged, you should try to get some feedback from
at least the original author. Xiubo Li and I extensively discussed this
back at the time when he submitted the driver and we came up with the
current code as the best approach to making sure that clocks are on and
off when they should be. So if it's not working for you, I'm fine taking
the patch if Xiubo or somebody else has had the chance to look at it and
review or test it. So a Reviewed-by or Tested-by tag will go a long way
to convince me that it's safe to apply.

Also you enumerate all the various bits that are broken, and it would
seem to me that they could each be fixed individually rather than go and
implement something completely different which might have undesirable
side-effects. Such an approach would also make it more likely for me to
merge the patch because it would hopefully be more obvious what is being
fixed and that it's a correct fix.

It's not that I mind the rework, but I'd at least like for someone to
verify that it's all still working on existing setups. Now, I understand
that people can go missing, so if nobody were to give you a Reviewed-by
or Tested-by for a couple of weeks I'd even consider applying without,
but as it is, you didn't even Cc Xiubo on the patch, so he's likely
missed it entirely.

Thierry

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWUuBMAAoJEN0jrNd/PrOhCLUP+gOUGXqHrL14WMdw1iT/h5hW
Sg2ul9EhxjeYGShLJd55NoQ9MeBtMApU1B5EGCNp+yt0xPLPiSFZTYMCzrcKLSur
qhpfw45wTacZnOEoz0MKR0AXfOyKrdCSgQ2P7QCGK6agdT1YIQ4KtKOAU9kbI4ZC
zfn3MVm2zZsckkqMOtHYD78+Jj5y2d3X6mLBTGMqgzC7lQASL/l+3/hjhBcvZLv8
QqGiWaUrC7R34xNvTi9PIl4VotiqND3zGA3dbZ1z2B0yywR6nf8cOJdxTjoBBcgE
hn/iGD/OBDQKC0S/OLB+iO0DjFWIJkKSPegDTeuH8OCtJNkk363yfzEFVnU9vapk
C7MVSZJJHkRbvICu3+zImBerMMRxDybqAFcPmDRoTsEiDGX4o5U6s9gnoypPKK5V
Q2705MDuocq6Q10l6y9YDKJX1BOx9Qu+Xg9fxoak8O5Ztr/lmIi5hFkj24f+EOeT
P3+22TCqONFk9PKE181WFUxxt9C8JNRGpxArKvjTcYHxrNPwMuhB8570pItRBIEp
7OM1WeAd7aXroLA1Mlh2OTHkMfkSPXJ6ooiq4SI+NBq9kGYe1CNooGWRPaun/7sr
/aAavVLcIhPfNL9iQMsfNxLLfAWmTYZktyMdjOX43Y9VIZEVK2GFPumUtshdH+wZ
RrQS0x+BO67Dgv58AmXw
=g7Cw
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
