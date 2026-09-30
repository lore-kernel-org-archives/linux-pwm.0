Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FFC390200
	for <linux-pwm@vger.kernel.org>; Wed, 30 Sep 2026 09:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790762049; cv=none; b=guHHHBjk9VFrOPQT2Q+vt3jvrDzeTAItaKpnRELqM51KZdP+XdIsKUoBwZLwTmT8UH/d3C1ustd5/vV12F/64kqtlJLWCpAR/DrSYrVaMCkmuhM2dARTk14+X4gFujcvkHSLqJo7WoikLQioVWk13GZe/PwPmv7JLFqRyIUTX+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790762049; c=relaxed/simple;
	bh=oYL9oH1pXlCS+NfSHpgzBfzfeCrlFDoWfdxKdfswLFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=laOVwFB0ATuEfboMYORB8XzsZoBbbCxVLPQRwEuXFpjKPS8WPbxwhzkiEPKCOSUDcigDqpyAswhsYvo1pGVwa7vRdi9sA48n7JT7LqyEd162e2T6DiFuNemDqD3t0iB5SjEGX2WB6OEGk5+Dp5Qg/wOnTyM29+ViHTYZBQkvje0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=CMYysObh; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="CMYysObh"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48b01c41135so273164f8f.0
        for <linux-pwm@vger.kernel.org>; Wed, 30 Sep 2026 02:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790762046; x=1791366846; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oYL9oH1pXlCS+NfSHpgzBfzfeCrlFDoWfdxKdfswLFo=;
        b=CMYysObhr0Od4BQyTTPNfziEcNig+pSClHT294L5OwshEmvvD4+9TbgsAtCR+G7nd0
         U8lH0g2vkdps9omWFpKLUGlQnJM/CXsyYLgXn8nJUNoYory0Gy0vrl7C1idvPMHbp9+W
         MLmujlIUi8TtuNr30KU1cxdBXEHwuBHqfrJYRFNBoBjszo3i5NYygng3REDsZwuoIr9z
         HfmK8dV+3mFkkm5W/5gHW2gkVcVDWvKYcA20c8DnAAZHKNYRO75KkxQBqBdHBCEZiXrG
         n4+LGVh122OhXVcE5CSU6m0hV3sZc+CeGJKvrisQ7TRF5nRK5DMqCEzHJlh9Piinks+I
         C0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790762046; x=1791366846;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oYL9oH1pXlCS+NfSHpgzBfzfeCrlFDoWfdxKdfswLFo=;
        b=i5qJKh32dMuqo2j9k6y0CL6Z9S0RG6zqg/bWeBWoeTIiVRtQwa1ku//UxMnRP+tLyT
         U7DBBpcmrSpVIeLihVnABrNXGNhk/6JyXCeDu0DjmWP/5tC6wLna0/USUqVsz+EkE6jH
         VjjKLPOZ0Yz3p3xbMjaTPylB34Juvxypk8vpQOJr6REinEgGT7ICLo58Zqhkkgw0+hEP
         kYYObl/DeLKOu0dyCmWI9K0t/yWjB+Nml5qBGN4Eu7Y40fjFLEKSMP8WVD3OF8tKeGme
         bEcBhWo197dYnNKRJiOfQljf8I63il7VuSJG1fISCQ/OECMv+KUHR7cUqhuNzX8Gmaoq
         MeiQ==
X-Forwarded-Encrypted: i=1; AKwUvBzEvdsh93z5PAuT0wHILIuj5RDbnD0LbMP+4ftrKyp7tn5Qfvj8jegkd6k4LR18g8weW/rnurH9EsM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ0XcAz5vvpNMnm1/zGhH+BrbfPuurBxoPappC0Oegxn9YhD+xO
	MUX/ypMa3kxAbIP5PEL7oPOAR2ZwSeIQNzp/kDTGGb8PkQy1YHNLxx/OmaZfPrT5JGY=
X-Gm-Gg: AYBFou1JBRGu92W0uCLPcwv0BtF4SQ0HhDxEG8EETtGrbxYg2apzxb6RyG4ckdRbR5b
	OYAQZG464w0k3CZJMObvyFhtFdGKLxyIaqyDRhK14BpAst3TcFMW58DLgCdUPqlMLXLhAZTP5OK
	mgkyHSeLQNv1Vc8llq++g57Gav5MMaIdO4E18wFU4ROai8nsc/KaJxrerrxCeOzYM6jm1hsQMcd
	6lAPQn8WKZIjye1dUUa23+kMIJZKifl3w31zl7NqEQxBvhuiNw/7haK/vf4jAqLqMcHmEWvEJ7P
	a5KiM/VGHUECCy3Tj5b/nnDYajbp1avehe0Tq/vjQpzqkRDnxZ0Q9Hb76ZpGMeFL0NLQcMNlSKd
	KK9gnbH1Up3Jxango7VNa929OIbXpYs9zxjX68yUk7O7M8EfZ+Ovi5JnaXfxPnF40naR/nTGFJj
	2nLvs13yD4TJypmqqN502TAH97XQpXLybx6BWyodGhQqqOJLGSgf0Rh3ZO5IJmdSvS7IxaGME3U
	Ya3HAdeHPN9e64EqWzUA+lIEWdcn6drSYLWreg/P+LflvlBWHYUtqj1cBvnyw==
X-Received: by 2002:a05:6000:2289:b0:48a:fcec:2a1b with SMTP id ffacd0b85a97d-48b024de5ccmr1835899f8f.17.1790762045816;
        Wed, 30 Sep 2026 02:54:05 -0700 (PDT)
Received: from localhost (p200300f65f19a904ced9d7b419fb4926.dip0.t-ipconnect.de. [2003:f6:5f19:a904:ced9:d7b4:19fb:4926])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48b029be71csm2446492f8f.9.2026.09.30.02.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 02:54:04 -0700 (PDT)
Date: Wed, 30 Sep 2026 11:54:03 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, 
	Mikko Perttunen <mperttunen@nvidia.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Ola Chr. Vaage" <ola.christoffer.vage@scoutdi.com>
Subject: Re: [PATCH v2 3/3] pwm: tegra: Implement .get_state()
Message-ID: <arzcE4nVRTAK9C-X@monoceros>
References: <cover.1789741839.git.u.kleine-koenig@baylibre.com>
 <b72b16cf704aa662a1b49805db284379d4fa4050.1789741839.git.u.kleine-koenig@baylibre.com>
 <arEAjOHU4rH5aGqb@orome>
 <arE932ZcHGB8RAN6@monoceros>
 <arJTSEfkILPQmqNV@orome>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y22qctwx6an5bvpv"
Content-Disposition: inline
In-Reply-To: <arJTSEfkILPQmqNV@orome>


--y22qctwx6an5bvpv
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 3/3] pwm: tegra: Implement .get_state()
MIME-Version: 1.0

Hello Thierry,

On Tue, Sep 22, 2026 at 12:07:26PM +0200, Thierry Reding wrote:
> On Mon, Sep 21, 2026 at 04:26:03PM +0200, Uwe Kleine-K=F6nig wrote:
> > On Mon, Sep 21, 2026 at 12:18:16PM +0200, Thierry Reding wrote:
> > > It feels like this has too many assumptions built-in. That's mostly a
> > > predefined issue, but I think if we want to get accurate hardware rea=
d-
> > > out, we need to address this.
> > >=20
> > > According to the register documentation, the PWM depth is 16 bits wide
> > > (on generations where it can be programmed). The value defaults to 255
> > > (which is n - 1 encoded, hence TEGRA_PWM_DEPTH), but it can technical=
ly
> > > be reprogrammed to any 16-bit value, as far as I can tell.
> > >=20
> > > So I think for this to be correct we'd need to read out the actual va=
lue
> > > before overwriting with TEGRA_PWM_CSR_0 contents above. At that point=
 I
> > > think we'd need to either adjust the mask to be (2 * depth) - 1, or
> > > maybe better yet, avoid masking it out arbitrarily based on the depth
> > > and instead cap it at depth so we never exceed the 1:1 ratio for duty
> > > cycle vs. period.
> >=20
> > As long as .apply() also hardcodes TEGRA_PWM_DEPTH, it's IMO fine that
> > .get_state() does so, too.
>=20
> Okay, fair enough.

Is that an Ack then?

Best regards
Uwe

--y22qctwx6an5bvpv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmq83DkACgkQj4D7WH0S
/k7y8gf7BWcjviv2MbZpF6/L7O+pa4kJgs74sIcYSavHGEvs1GtV6L0xs2ZEoiTq
WBxy04DIWT9xFsxPXj5DUAM0vdu+LDCMq1ZWiioW05IU6znBJrDXUtQ2kuXjDUJ7
xshcSmRoxp4o5AuAowV1BRiYJ/LTva78xhUdtwQAEEYO2NhIr2nNhYXDk76QFv2z
+AfILHCm405dcqYt4mYGTdUQX6Lu2+FUS1eA5r7qJHIay5WOZIcalcsVFjnUNnmH
EiyG8SdmGBKX9VjsWXtKIkNHrwsZhU+ThyOkkK+h1bkwQIyoospDEDz9b8DaCh3K
L+nRCjY0qixI/6UzybWoldwuCnntRg==
=5i9Y
-----END PGP SIGNATURE-----

--y22qctwx6an5bvpv--
