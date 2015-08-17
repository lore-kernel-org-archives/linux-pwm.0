From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v9 1/2] pwm: kona: Modify settings application sequence
Date: Mon, 17 Aug 2015 16:25:43 +0200
Message-ID: <20150817142542.GC6891@ulmo.nvidia.com>
References: <1434403262-24198-1-git-send-email-jonathar@broadcom.com>
 <1434403262-24198-2-git-send-email-jonathar@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qtZFehHsKgwS5rPz"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:34186 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308AbbHQO0w (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 17 Aug 2015 10:26:52 -0400
Content-Disposition: inline
In-Reply-To: <1434403262-24198-2-git-send-email-jonathar@broadcom.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Jonathan Richardson <jonathar@broadcom.com>
Cc: Tim Kryger <tim.kryger@gmail.com>, Dmitry Torokhov <dtor@google.com>, Anatol Pomazau <anatol@google.com>, Arun Ramamurthy <arun.ramamurthy@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org


--qtZFehHsKgwS5rPz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2015 at 02:21:01PM -0700, Jonathan Richardson wrote:
> Update the driver so that settings are applied in accordance with the
> most recent version of the hardware spec.  The revised sequence clears
> the trigger bit, waits 400ns, writes settings, sets the trigger bit,
> and waits another 400ns.  This corrects an issue where occasionally a
> requested change was not properly reflected in the PWM output.
>=20
> Reviewed-by: Arun Ramamurthy <arunrama@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>
> Tested-by: Scott Branden <sbranden@broadcom.com>
> Reviewed-by: Tim Kryger <tim.kryger@gmail.com>
> Signed-off-by: Jonathan Richardson <jonathar@broadcom.com>
> ---
>  drivers/pwm/pwm-bcm-kona.c |   47 +++++++++++++++++++++++++++++++++++---=
------
>  1 file changed, 38 insertions(+), 9 deletions(-)

Applied, thanks.

Thierry

--qtZFehHsKgwS5rPz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJV0e7jAAoJEN0jrNd/PrOhdqQQAMI4EK5b5YKCcuNlbZsNMY+C
D7HBRYalUFT5wPcCMFYdJwnOkYO8s72KrHFGLK507nRe7I+HFBwKz1FFVVkKSVC9
gBCAKScsP6FpNMnweOPozk8iBdi0sUJaDZef8v40YmDefGv+7DsdmorzvIjlun6I
pvfGbQS9ZYEHMnkGjlpIDA50zwo+4VA3MZHnpEr5/lTww1bbJaAFi1GNnolR+Vjr
ecee+XGwo8zX2+Kd/bJ5Cg4J2F3HmdeFKDpPjGJFjmfsyECqyJq5MJyGVGvG7oh4
xCPqFIvvzhXIl/L2biig/sjxPp0avNrG4v7CwYJxSle/QrxdVhmwZKXrdrxHBvcK
mwuA6M48TdwewStgDFZkSNHJHmc6mQ0/21mt1VjXvXIlj00FTM+yn33sOXRn32Nw
ve8E05zaEDdGGMFE4YcdJi5UHDP52VpA/cZ+hSgerm1qW6jEJbdrq8QSj0qt0AUd
KXUNfxsUMjuhc9yW7yoPjDlWdrAOvIx0IQkXoMkraaordn9Lkn743K34wducoqY+
5kxxoVfp+Lchn6VC6yyOLlJyFsUUvmrkEmaD/NYgLitpF8WQ0/hor1+vYgfxKMvZ
Lk4TMNH8y4OITfkMIhASp6NwwhrA1fFw7ihJDBUpJe2R7m0K8VD/RDdWvWAERgxa
wic5MsOT/D4Fhh93TYg6
=jJd/
-----END PGP SIGNATURE-----

--qtZFehHsKgwS5rPz--
