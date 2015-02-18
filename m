From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 0/1] fix for pwm-mxs period divider computation
Date: Wed, 18 Feb 2015 13:08:26 +0100
Message-ID: <20150218120825.GA18576@ulmo>
References: <1424247536-16476-1-git-send-email-ghug@induct.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:58531 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245AbbBRMI3 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Feb 2015 07:08:29 -0500
Content-Disposition: inline
In-Reply-To: <1424247536-16476-1-git-send-email-ghug@induct.be>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Gaetan Hug <ghug@induct.be>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 18, 2015 at 09:18:55AM +0100, Gaetan Hug wrote:
> Hello Thierry,
>=20
>    I found a bug in the pwm-mxs.c driver for the i.MX28 platform.
>=20
>    The driver computes from the desired period which clock divider it
> should be using. This computation assumes that the link between the
> register value and the actual divider value is raising 2 to the power of
> the registry value.
>=20
>     div =3D 1 << regvalue
>=20
>    This is true only for the first 5 values out of 8. Next values are
> 64, 256 and, 1024.
>    This affects only the user only if he requests a period > 0.04369s.

Can you put this description into the commit message of the proper
patch, please?

Also, the subject should be in the following format:

	pwm: mxs: Fix period divider computation

Thanks,
Thierry

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJU5IC5AAoJEN0jrNd/PrOhZvcP/2SjXNg2efkNbgXPYyT7Aicd
pKgk/2Pr2hTtxoSp0Vyxpgf58wQMC4/1hznq9UeIviOzADGl2ZsYlqj8734Pxo+W
gIew26wUTdZtF8iJUCfqvahlz9GjksW1j8s+W5onDNghTvQdthPL/Hnh2w9Uz0i/
kNo+jFPpBR58d9HMDBqlwbFa602vFd+VW0NhTWlBxtZuIvQG0lPvFrJ0t2VlO9CP
NVBOig4l0seq6Zn3LVQnmsZDgsvkQnqrKoRuFVA620wn+MJ+eCRTVTTCAIcdLcxO
Mi0NQA0URoSCuaQT7qlIUFwxQ2Ah6a5TV4cv3H2tOx8UKhxHTXyAskNEvS7FSy0+
/D/LA1zq4QyLXvcpRFctXVH+5UGpkTEZpXG03oeASKY3eCcazp7odIiN4nvi6T5g
HiMwf8OmOMR+oIakPZRk6oyJQLeAz/wAdmI31SCHkiUQv9bZfSpNEiT3CalNlfVa
fd4u4etowHBp5fOFT9LqxdiCVOslRSqHTuJnsk7N7lMTo8B8gi4TUeJcKGOgGizv
eiXJVAk4tG4nAoI/UjIkpmPhy6CmHndHKkqnxETfMqXwyT/33/m44EjZ7N7Z5e6W
FOP2V8TlCc3G1psy9SM6jKabtSBepYFkSCcgFGd+4h6t3stv74sENVeWaoC+dUQO
yq9F/VRvTN/Cw3ZQrcJm
=8Ayq
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
