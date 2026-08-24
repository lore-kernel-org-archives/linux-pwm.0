Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A87346A08
	for <linux-pwm@vger.kernel.org>; Mon, 24 Aug 2026 08:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787558687; cv=none; b=Mgbe7YO/HlOaBsOQtFR6dYCMPkEoOxwk/1F7knYLH+2c0hEZ5L9bhYPp+5hPu8Q+reLB7uMHgynyT9ZhbyE3WtdvnHCmQvF4HYXOAiGBUyvX9V8hdMOVDDTMtJS3QlpxoyKToP6G8+evsbBFjgtf5wKdOKx1VKMyYsiGnoXbtjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787558687; c=relaxed/simple;
	bh=XDNP9sGNVSgP4Ks+3cqzP4wb+3fLYzkvYqb7oZQQZuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DicVgadoc6ynx857sxt/gKlWZn3QU1sfx83IKbMe/KCgMddmBBgF0WgwHIK77TDdixU1MOMSZB+KrOJACusMQwdKi9P9U/ET8OsLLf7NEErS1ESKhuuUt2qesusr6IS2BmYeEFWgneMSnfy+hnESiLtoMpS3FATN6CxCXvUmtMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=P8FuWRWA; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="P8FuWRWA"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c15d47266baso354808166b.3
        for <linux-pwm@vger.kernel.org>; Mon, 24 Aug 2026 01:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1787558684; x=1788163484; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XDNP9sGNVSgP4Ks+3cqzP4wb+3fLYzkvYqb7oZQQZuU=;
        b=P8FuWRWAq2MHs3OI2eP9+Okl1+YHH4ViS6lJzRnnxTewsZ95u6aou5gQ4cb1eoD/v/
         G5u/kaA3SRvTik/wXFWjJxY9eXb5F6oR8foWZMyLv9rF0kYtzBW94ESdhXALNNJtqABP
         PBsWRchdV7cfhK0rswlBXwNKZ7/echGBOlJhdKUwfSogiFYkI+AITpEvPZ0TobsTw+oW
         xJ5/SSbCWTbouT4KFJ7n3RCzuuM4X+LOgvuGxowts+pkmFkjyZ+Yq9F3uJ92wpE1yM4M
         tiqp6Ti2fQJPtcZNBAEYUD8gjqMH1rLiAoG/vza6x38a00dMItANwlBGaCPSX+peDivN
         3DBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787558684; x=1788163484;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XDNP9sGNVSgP4Ks+3cqzP4wb+3fLYzkvYqb7oZQQZuU=;
        b=Pa1DNVTZVQZeUDrWdpdijrkjkq7dx80Y8Os5Xf7naKGCXzp2aBARQv+5xmOKm/D65G
         Q/cMm/dMkiEMHatG/QD+hikEQwjlgsbb35YZgKVdHLkQ4e4JJ6yEqQ0QRtA3Z+kS4uhx
         7MsIt0ws/Q55VBL2NcUea+sy5vSGauQQGlCYOJzuP68O2gwSOsXZQU16GUbknvvPJJt9
         GKZ8gCltIRyZGvbwgVay7niY7OlYohp3Q2HvqGRQf7AZrmWS2bckhq8JJbAi+vN7ynBD
         DBgtUsKZONIncZ54sDTe3XjmHxV0sEbUh0Fc2zGD95sH3zBogfJzgZuuMHdfm7TCs/n/
         N23Q==
X-Forwarded-Encrypted: i=1; AHgh+RqHwLk9OUZY/YTm9O9OnAkwY+akaBDOGN29To2V9SzsDTqa52d+x5ErRLyRZZcrnscVjA61RINqobU=@vger.kernel.org
X-Gm-Message-State: AFuF++kSoZ5hFQxG9fTt3BGJutSEwYF3b+8Q0WMK6sjf8lokcffMBe1d
	tUBxpOyr1t1UYP0vW5PgqVzQzB7vMEZqzEaHtPaWrc3Uw6zjk0U7owFIDfm/T/pUBKmYB6bs93B
	Hi59CFC8=
X-Gm-Gg: AR+sD10zDhZAnKq2+Y5nP1NEkobyAV1TV/T2ckDJFQZhQ+xLqT0rCA6mgd5N+bCUSdt
	5+tfefeLowOl/MYR696Nf2tDZmBnQ2Skle7Ma5mQccEFZ5i6DBdXXpVk1+Ja9M3s4HODms+mXL0
	qGf1EGqDVrsro7aMgWreuyCUROVooHbnmnfdsO+PwsGu70ZVMNqmiYDL0BxKldXiwoIlBz2C7n3
	lzrh2kcLsBnpwQ0r9S5k7A31troh8t0Ds4011Exy/8EWdoliWx45RnbFgZDpHoHMrsil4KryRlO
	ahA9WeMtj+9V+nlmF0eSzTwS1KXp0JP2Kq0p0bsBPSHTEGnksbTRfeHSWGuPNwKorLIHy7ASpDZ
	bogoDntGvcsWysACjo+Moxqi1lRAtebQ8U6uIjZgKafTxBQuoB9fvyBFrHbVTCuEHIyg1PpZ4Mv
	18sdJ1HnHjNt0y4v6twru4LL+Jyex9xFXzwkSZORGoRdyx1kcpsj26dpLAT5RCQPk/lmDBTaNa+
	UdkCg9Rx68iolvdprOqYIQpKgLZIoIWVibmLOTjN8rC12pSNRZy
X-Received: by 2002:a17:907:6d15:b0:c24:4128:c19d with SMTP id a640c23a62f3a-c246a2e9378mr2551285366b.4.1787558684110;
        Mon, 24 Aug 2026 01:04:44 -0700 (PDT)
Received: from localhost (p200300f65f19a904efa8a94b704adaa2.dip0.t-ipconnect.de. [2003:f6:5f19:a904:efa8:a94b:704a:daa2])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-c249606b683sm1251855166b.5.2026.08.24.01.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 01:04:43 -0700 (PDT)
Date: Mon, 24 Aug 2026 10:04:42 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: "biju.das.au" <biju.das.au@gmail.com>, 
	"sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>, "robh@kernel.org" <robh@kernel.org>, 
	wsa+renesas <wsa+renesas@sang-engineering.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v6 02/11] dt-bindings: pwm: rzg2l-gpt: Document
 renesas,poegs property
Message-ID: <aov6v5dObK-zJfRj@monoceros>
References: <20260604095647.108654-3-biju.das.jz@bp.renesas.com>
 <20260604100619.75EC51F00893@smtp.kernel.org>
 <aliM3iVA1LY7tW38@monoceros>
 <CADT+UeB-gV8QnuwpTUrHV-GvYPwebYg=RE68PcApZkACO4ENDw@mail.gmail.com>
 <TY3PR01MB11346EDD83D9CA3F3252D48F586A22@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yhelts2hapldhig7"
Content-Disposition: inline
In-Reply-To: <TY3PR01MB11346EDD83D9CA3F3252D48F586A22@TY3PR01MB11346.jpnprd01.prod.outlook.com>


--yhelts2hapldhig7
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 02/11] dt-bindings: pwm: rzg2l-gpt: Document
 renesas,poegs property
MIME-Version: 1.0

Hello Biju,

On Sat, Aug 22, 2026 at 07:54:26AM +0000, Biju Das wrote:
> > -----Original Message-----
> > From: Biju Das <biju.das.au@gmail.com>
> > Sent: 10 August 2026 09:43
> > Subject: Re: [PATCH v6 02/11] dt-bindings: pwm: rzg2l-gpt: Document ren=
esas,poegs property
> >=20
> > Hi Uwe,
> >=20
> > I have clarified the use case with Rob on [1], and he acked on [2] .
> > See the details below
> >=20
> > [1]
> > https://lore.kernel.org/all/OS0PR01MB5922756F1836AAABFF62C04786049@OS0P=
R01MB5922.jpnprd01.prod.outlook.co
> > m/
> > [2] https://lore.kernel.org/all/20221215205843.4074504-3-biju.das.jz@bp=
=2Erenesas.com/
>=20
> Is it ok, if I drop the POEG support as few SoCs such as RZ/T2H and RZ/G3=
L needs PWM
> and this patch series is blocking them. Later I will send patch for POEG.
> Please let me know.

You can also reorder to have the important bits first in the series. I
can also apply partially then if I'm happy with the base support and
there are still questions for POEG.

Best regards
Uwe

--yhelts2hapldhig7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqL+xcACgkQj4D7WH0S
/k5q7gf9EXjSbZmnkiK66pzWl5IRYULgilZsieiRyqDExXbIofVEhxYmfRjlv8Qk
SNFUgIMRCOAK2BE+7iwPlJvCP3gMCnx/47ZEZmz3sykbgdgjyW96YPL12tsHpAC9
wgtHAEdKLvn1WrkVQB4N0LCsnbs5zXoc1BdR+w5vOZLzW4RgdNRQuizJ80czjdQ7
dV6vq981FKkyftinsY+e4bLH6Jlk+QaLLSc8gQ3CW4Zf2J1V1N4OFvAPryGKQ388
TvYs6OWt5RRFAfUTYYomIvwA9H30Olp9uh8weGokQ+/wvCHFqQm7bddVNQIwq7YM
x26KbVqXuLL5WSvfqVs02DuzCdv5yA==
=b9qz
-----END PGP SIGNATURE-----

--yhelts2hapldhig7--
