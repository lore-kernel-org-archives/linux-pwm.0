From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: imx: use of_alias_get_id() to get pwm base from DT
 alias
Date: Thu, 12 Nov 2015 13:43:58 +0100
Message-ID: <20151112124358.GC31671@ulmo>
References: <1447248241-18352-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jousvV0MzM2p6OtC"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36471 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750723AbbKLMoB (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Nov 2015 07:44:01 -0500
Received: by wmww144 with SMTP id w144so198795724wmw.1
        for <linux-pwm@vger.kernel.org>; Thu, 12 Nov 2015 04:44:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1447248241-18352-1-git-send-email-mkl@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, kernel@pengutronix.de


--jousvV0MzM2p6OtC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2015 at 02:24:01PM +0100, Marc Kleine-Budde wrote:
> The DT probe uses a dynamically allocated base by pwm core. The actual pwm
> device number depends on the probe order of the devices in the DT. This n=
ot
> intuitive and sometimes hard for users to map the Linux pwm number to the
> actual hardware pin. (Especially on the mx25, where pwm4 is probed first.)
>=20
> Use alias to identify the id of pwm port and pass it as base to the pwm c=
ore.
> If an alias is not defined in device tree, a base number dynamically allo=
cated
> by pwm core will be used.
>=20
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/pwm/pwm-imx.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

What is your use-case? The base is merely used as a way to set a fixed
global base number for the PWM chip. However that global namespace is a
relic from old times and no drivers (except for the very oldest) should
be using this. OF-enabled drivers certainly don't fall into that
category since there is no need to refer to the PWM devices by their
global number.

Also note that most users of the legacy API are now gone, so the global
namespace will be removed eventually, so you should not rely on it.

Thierry

--jousvV0MzM2p6OtC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWRImOAAoJEN0jrNd/PrOhpEsP/1UKfaH3WCa0yVETBa/M8zCI
iVu6VznlEQdplTU5Obf5ZfrSnllCVtlN+R5JOd0zMQ6VOUsz2aXp3nYXXB4xT0HT
UQ5Sb+8QnADiDEEnixw/o6ekiNdLYJgqnYQxo484xazH0DIDibidNDm3P2KR0CD7
NeYU/sVxpQEMe/UJNGT9sPPre8b2WQTBsWZC4otXJB0uf1fAfmtlRk2lBHwQLquq
3+VHniGsom6qs5/REuL03AhR4Bc/I3wqp41KvWDf3ra3p77lJpIgj4aQJGh8+uSM
GfP/8zfFZWVF0HYnYGpvFitv0eHFjKBJ8eScKkr8zTahkCOS2dPj6v7/FmPLYijJ
ELiLF+xdrCd1l/9Z/4GpsFt+s/HtPFOkvtudglRYjnOG3L3a0ivedzJIBYLQTME5
jcktfMu3b6kO4BSYWq4py9MGngPRE8P56USlZi/lIhmxsdJJwarj4pebgRmllH1E
A0GEjCkTAt57M5puH4vPkd8O/LDHmsRJxhZwL/Mnu0GiNJ4sN8LX3tJ7MsC68IMa
/D6h0lpQdresvxlgEYXqgI4aNuZtzYi1m/rNC+mNrjRa49Dgl3qvNJSJ/5Lpvxq8
nxm+619MHV1YTSPipdT8aU50jYpY6sYWy55LEYQP+GsU6gNSktOFv7YyaDYqNQDN
/e2Kyi9hSDMyQAjYWJD1
=RfQ7
-----END PGP SIGNATURE-----

--jousvV0MzM2p6OtC--
