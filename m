From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: Fix of_pwm_get() for consistent return values
Date: Mon, 4 Jan 2016 09:10:28 +0100
Message-ID: <20160104081028.GA23749@ulmo>
References: <1448803057-8572-1-git-send-email-albeu@free.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:32937 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064AbcADIKb (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 4 Jan 2016 03:10:31 -0500
Content-Disposition: inline
In-Reply-To: <1448803057-8572-1-git-send-email-albeu@free.fr>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Alban Bedel <albeu@free.fr>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 29, 2015 at 02:17:37PM +0100, Alban Bedel wrote:
> When of_pwm_get() is called without connection ID it returns
> -ENOENT when the 'pwms' property doesn't exists or is an empty entry.
> However when a connection ID is given and the 'pwm-names' property
> doesn't exists or doesn't contains the requested name it returns
> -ENODATA or -EINVAL.
>=20
> To get a consistent return value with both code paths we must return
> -ENOENT when of_property_match_string() fails.

I'm not sure I understand the need for a consistent return value here.
These are all different error conditions and the only reasonable thing
to do here is propagate the error code from the of_*() parsing routine
that is being called.

Thierry

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWiijxAAoJEN0jrNd/PrOh2qAP/jCglpA38bX1zZy0wmZf9apN
9gI4HdD6KVl1PrhyvA2AChL6e6UE2Qnl+4SLizjfb5eU8g2jCqhND/Zult4Ayszl
qDqPs+dhas8iE67dG8LNbcw1F4/02yKLKdpv1vkeJTxKWbH80uXnARfGEdPn9F+L
QuRpmHGdk0l/PQwzjKLyJlo+8spFym19MDo/LtfAzergD1BHpRQtg3It4AYoRYev
M4T/bPCbqY19Gz5uifacXXvwZJJ94oi8QnpWxDmn/JqEId2eXYCtFD9T7KiggCqI
/rW1xE/WD3JX34D6+ixkmCQNH2S2Pc3G8QVjgZ8BN8zKUrlE65V7C2Nk4p1+ZRYQ
pXsa+pJIU4JBAcodzbrH0MFnTEThK0f0bB49Bm6TkQpYI0zJnoDBgmt2KFxMSYKo
546lLM+z/QJX1gjPq9bfTEVqRVD0pvaetYNCxOZ4Jez7rxW/UGrjG1vX4ZVweqv/
szXXSzpk1AQgNzqZ08UUPlGdWUsXx4XRFolZd5MY70qhVfAjiw4hBHTrxkAL2vll
uF4ADM3C9Vb4kSngL09V9SAlssa2joXZaRw6zs3a8tDsnaPsX/49cyzPQ0gJclyJ
MMeZC5aiInIgO+hdIePXvIgcbFTmAor9BhtxIHqUoipaPZYo4A/vSOkb07CtE2r7
Iu46R7+vUsr8pM+u3ZjF
=31/3
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
