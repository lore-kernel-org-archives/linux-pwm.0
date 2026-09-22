Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E2943E4BB
	for <linux-pwm@vger.kernel.org>; Tue, 22 Sep 2026 08:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066003; cv=none; b=kwYJB6XAt4A/WLivEWFTzgDe+wu5CHOBhtQG6xPDaKUcslJJv3s5DGFHrs4VJKRagIE10HgK87GU1toLJmEs86xQ3Tml5roORUgFd80wySuhxbmcI1p1HQspliYucHp/LRh2N2QAMIeGK6n3c8Qr3EDDiaQf2wy5iIE8OUcdHfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066003; c=relaxed/simple;
	bh=zEomBp/JAYre+ACaiHStIXFRKfBN3mk/YZOtMfOIzaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lL5xW76ecCn5sTDjJJV6pTDVXQW+YImWXKzXX5AKyzkGbtilnJRKnwjVQH9H6hsvBWTSgQGRg+IGp7j4KltzxL93/aZN2MmNTiPAkPNkJz7pqlMPAXGxUW5iLHGlVV7tipZWFEUammVWX9Flp5gAHcK7P+pYfETq2tJ1lPKbQBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=SDFVaqqZ; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="SDFVaqqZ"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d3920so26272235e9.1
        for <linux-pwm@vger.kernel.org>; Tue, 22 Sep 2026 01:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790065998; x=1790670798; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uU9EGsP0jhjlOuyY9ffTaiqx8NHl2A4tqCF5zEPkwzk=;
        b=SDFVaqqZfU84z5zv8A0dBFvjQ5ivbjNkUHmEJ7qXw4RP033lXmvKCIDV0XMZNXCfRB
         ui/pPwbTZABAxe3HFMjfc3b5p/QgarOU2p/jqEl4x5cmgAsvAXZZklTW3gw9MctW4B1w
         puOuBQA6N8M4qtoWTLlrbp3f7obYQIrRDVzCW/k8YGESOy49RuHBOzzkXtMA8z9VLPZr
         lh6zJXb11GaufjqWPGfATi+exGxn3U5GRs7jNkQNKNPc+A7Ukxr3e4UUTlTs6CseUm3r
         1yhGWo0otGrC67Y7qvaRzSed99ajmtn1bqBwcTF5aO4pohbI/xJBUDjj//vwpyALMepV
         U0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790065998; x=1790670798;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uU9EGsP0jhjlOuyY9ffTaiqx8NHl2A4tqCF5zEPkwzk=;
        b=xLcPOyH/reiws6/fSy4y8AYwNaYqAXPyJtVxkr6Jl4HlvtJx3Mk3EJtDrrdN5htZxf
         igMRzWNDnqM679ihRCl6SBcweOwPxg2WKeZnBh/sKCUf4+4FP+eCmhcpDNoJnC+JaDki
         D4rvxAnbVlJeo6fGrizoDVMlZyNNpIPTMlfGIp6YsHaIH0FEbqBtNdEkxY7unCKYNq3/
         9I3PC3csD8TK6YYf9EdnjVHsIcRY39tl2dGlGmDUvXeBZYInZGE1SlnNT9JqIa2jiARW
         A6YP2RbBepMqINVKmQYlRFUX9IuGbXEsZxreNTfYBy4L31TRmlA4ES3b4IdUvyRq4qmy
         qP8g==
X-Forwarded-Encrypted: i=1; AKwUvBzK+ECdWqZG9qxikA0r/cxty+zg9Phni7OXac2IaUqjO3vIjBhZOw+xu7EmG0W7tThttLw3T0a+lf4=@vger.kernel.org
X-Gm-Message-State: AFuF++mZLVKBFRcbsiRWD2YNI1kSrzG5YUCTiV2NFbOm3THcYKaSzWnE
	Bzx66aEo2PHtjlYMKgPwKRl3juHbEKXmbSc4z+XKuAgZPxyY9cVAZ+zg6vVeHX0LDDc=
X-Gm-Gg: AYBFou2qo0K3U6Ac1HVZeoiOnitLfroqdaBT7dztTc/SMvCI2T/4fTd2XcjgtXR+77U
	lUoZrQCumUrnsWnyvf9QSDHpBc5895DTSGsjF29m+SrxPBFBMgx/zcwV6E83+kZDrNQBqhhD+4E
	OaR9Bs214aTBKFEn62UH0Lve2n0Dj0co3rn/7TasGeHdWDE0YsjFRdmhp1cdqaEjT3pntHxC3yJ
	rCP6Khwzv1UMN9AZLGSeoZlQKYC/o5cRaG6ae//5nzhC+xINQDFKOzxINo8tkTzJPpaWT8MA8TO
	llcubJ+JHfu11mj9FzvO6P2lHskMV5UZqsYDeMyNJHTcKA3k9Z+giBQ/Xqm7dLEkY9R2WAMqDOp
	bQoeV2At5bDAYEnLh4jkwT4KNEr9+TncHVTs9feAnrXzYmp0pHfeUPCpELAAaDK+846/AfeEflk
	/qutPnzbUW+r58V7NpV6udOWTVT3HOUUJIV2feK+vG0/GSRFPPzlIAkrvi9rvHda8T42NtBao70
	FmB9FyRX+v8SADBoQcX6wAHTu+vQnSZhO4cpR502fDPdCQQbjXS8qEhTnWVRg==
X-Received: by 2002:a05:600d:6503:20b0:49f:d087:6526 with SMTP id 5b1f17b1804b1-49fd0876705mr70277975e9.34.1790065997920;
        Tue, 22 Sep 2026 01:33:17 -0700 (PDT)
Received: from localhost (p200300f65f19a9041d0e57515b2ea4c8.dip0.t-ipconnect.de. [2003:f6:5f19:a904:1d0e:5751:5b2e:a4c8])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49fdaaf0074sm32730825e9.3.2026.09.22.01.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 01:33:16 -0700 (PDT)
Date: Tue, 22 Sep 2026 10:33:16 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, 
	Mikko Perttunen <mperttunen@nvidia.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] pwm: tegra: Check for match_data being NULL
Message-ID: <arI8vXaKTvEJi-Zd@monoceros>
References: <cover.1789741839.git.u.kleine-koenig@baylibre.com>
 <ed943d9be3b785514e0f65a5b8c13a78aba7a090.1789741839.git.u.kleine-koenig@baylibre.com>
 <arD7N6A6ncBNR1Jk@orome>
 <arE-s0zbTUn14aIr@monoceros>
 <arFYGka5NpcgJ8oQ@orome>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rspyuoriyu3xbsxg"
Content-Disposition: inline
In-Reply-To: <arFYGka5NpcgJ8oQ@orome>


--rspyuoriyu3xbsxg
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v2 2/3] pwm: tegra: Check for match_data being NULL
MIME-Version: 1.0

Hello,

On Mon, Sep 21, 2026 at 06:24:39PM +0200, Thierry Reding wrote:
> You're probably not wrong about opt-in being the more natural choice,
> but looking at commit 3d713e0e382e ("driver core: platform: add device
> binding path 'driver_override'"), the intended use-cases are very
> generic, so it would probably lead to a continuous stream of patches
> needing to be added whenever a new device wants to be supported with
> vfio or something.

thinking a bit more about that: The use-case presented in that commit is
about

	echo vfio-platform > /sys/bus/platform/devices/fff51000.ethernet/driver_override

. If we had an opt-in mechanism on the driver side, it would only be
vfio* that would need it, wouldn't it? That sounds handleable.

Best regards
Uwe

--rspyuoriyu3xbsxg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqyPUoACgkQj4D7WH0S
/k75uggAjU66rIYhxOlgu7NhEO7xA565YwhTBJeloD4bUMm8+0W08iZNphhaGPvO
uXNwj8m6MCl1yFVzOCumzKhF8r2ixYGsKW+vmyn59m1b/DAoL0KnjJjPyjkwizOX
eyNlZMnvMwp4Y65HaziLW9s6eTtc0fNMmGsrCVKvAjtGlZDsrzBZbRnun/Hd2pg8
J/lYgKQVwTDYJZZnxauPn5Qyq7pZ8Acs5JDvOi7dBto3YRcG8w5OFbnRL6HYAhgr
neCLHai/wCMyehrQVakEyRkwfYJmyiAMIIv8g0/uUlUF/exQR6RKtaJpd88gX6vT
X539Y2bk5qA9iu35MHWrmN+RXfuKOQ==
=XDmF
-----END PGP SIGNATURE-----

--rspyuoriyu3xbsxg--
