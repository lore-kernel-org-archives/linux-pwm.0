Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1EF463B85
	for <linux-pwm@vger.kernel.org>; Fri,  2 Oct 2026 08:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790930739; cv=none; b=oknaUCganVc+f9PAJPjSu7Q4LjMTonH+Pcw6Lf58OYgcNPlPYptBroCUzbsyq4hCC9KHn0vvw23MS0EdABycnh5MUpsaBe6j1ZvgvuAdoVOu4lrYjOQUttEomkcQmCb6Llf8++5CIezp1blkiJjESlw1DZAEPT7Rq3YxCqLz/aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790930739; c=relaxed/simple;
	bh=Q6PnvKn1BRiwuAqzPSQ8eJcrVGsr3TqLvA/X02jBtrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eVoROWZmFvBhALjwZBapzsiDszLypfOFSLepQDADy5160iylFnkN1A+h6rSYVDc+FpxQNk6QfqywRPuQ26/7YXASPr6upRE68cOv8zFpgd91xMuZeCX4Aczmkrgi5BvdaQ1YJ2bihdqXESZrN9ZDXxzoPzX8LG8YtAltFC4aAWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=czWAfk4d; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="czWAfk4d"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48afd5b1678so1509751f8f.2
        for <linux-pwm@vger.kernel.org>; Fri, 02 Oct 2026 01:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790930732; x=1791535532; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RiMp/HQ4MZJXXJm9zw0L5IH3yUyg4yANpEUs/YvjE0Y=;
        b=czWAfk4dxuQAuRSDhwAZ9MhwIIlJGUVyjn5BvzzA4awNNjKn04CgJ9ChYbo0iDpCqp
         W35iOTbUMt5d47t7N3eA2fJMBqQLZdSyL8o4OfYwSqPkl0dFLtaK1e4qg1dKoQz9gs6p
         +uIj7g7gH9HkRtzzUNnYQiR7C/MLrqSJeqmVN3GzVjaqOrTzw2NvsLNuBsqT+7dZ4/72
         XzyuepvtAuEE2UcKVvy0rJOuBGAYrAsxGvfxAN43ahadxwfY4uukXvicV3hJlgWsGAU6
         5lCDO10Q3hwCpbUTz7Pcl9/bUXyw+TsuocI4X8mV4ZNW6taBMpNZnEHAagOVMFLi6ON0
         q1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790930732; x=1791535532;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RiMp/HQ4MZJXXJm9zw0L5IH3yUyg4yANpEUs/YvjE0Y=;
        b=L8kmgI2Uu9NyrSBq/CS2qHe+9pjNa8nzqrKSo8uYTrvt9hrdZBtii0YNcpIMzPwS8E
         7s1QYLqqnCvW1KpeyvuLy4mGo48Rnl1ua1r2NXwX1nE4Elo+B7wJ45Ed6tjbSi97HMP+
         cuI/WXZP6kj7dzHydCF8p0bmlupRD+0YGG8IYKWQRN7epaGvQEZu82nzQebql6+wcYg6
         v/TfWF+26kT9rmrMOJuNFmcTJUAZ76jQsvCdW/iLgz57AtfMwdbeWfGkfTPTfbMFK+77
         pSZzBye1EJFL6sI5H0U2QTnz8neIXLkubImQaWANwUDT0kImVS/5anJnnoQsNe8fq6IX
         3Pzg==
X-Forwarded-Encrypted: i=1; AKwUvBz6MLJBqFENHh6+yTbCbFiucMbVB81ntoJrCqZ5vQ9BTxvYc8qDqI0/dlHMC063607CauJCm+j0dFs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ0auyY+zDB38sPGp8VWRarUu+K4SPsoCU4wTXIU49vZRo8AZQE
	SLIyHBMciGlCALtS1QQfgNJIOKnqnlzwKvOwzvQqFpiSkYWCIPWL7rFtQHOuY0UQ4bM=
X-Gm-Gg: AYBFou0feJ3xvlBLov5gNq17R00djfscLfLOhIgIUv+G4vi670eR1xXB+iI7EJKn5WE
	ehsvXnDhH3nnKGbAzk8/ctMd22rfrBujWce5HRUKRBZ8RpyMvEInSu47vOG7HNWk/oV3yPv8rFj
	MptIKmn3aRimtvNE5FpuJbFWbmAONsn2SsKqlBVaLcu+6zMQ1/swr0065azShWjH9VzCYKJ30h/
	/kZgdQVPimCdfKtukHZSnu95Pgp0fOfSjRofQNo7ycEaykRLNgXJUKIWxXYc2jj2+yV1UggJtnD
	ZuKewzCCEOGpS4R60T5zpW0oX18FWbKcaR4h+m/8ECj2ULhlXAcc87T70HvfFR0owNSEr4R3SUQ
	JrbuqQEhRPhGSoZv6c6TWMlGX4bs/XWPBOKTSbpAktO++1Un9wwkHBsl7BZILr5FKFvLfZRVHF2
	+sWa878cwwEoxLf92tB31kO+qf+Qrhho6l8vNjU8wVfPRiDOQ58P+QNzsdjmjsbasrtmEmJAs=
X-Received: by 2002:a05:6000:108d:b0:487:27f6:a4d3 with SMTP id ffacd0b85a97d-48b1274ec77mr2519619f8f.35.1790930731992;
        Fri, 02 Oct 2026 01:45:31 -0700 (PDT)
Received: from localhost ([194.213.108.11])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48b380f04e2sm3692890f8f.15.2026.10.02.01.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 01:45:31 -0700 (PDT)
Date: Fri, 2 Oct 2026 10:45:28 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, 
	Mikko Perttunen <mperttunen@nvidia.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] pwm: tegra: Make use of dev_err_probe()
Message-ID: <ar9uJyYyTh5bfM4i@monoceros>
References: <cover.1789741839.git.u.kleine-koenig@baylibre.com>
 <641219a7d76bbcd8fe98b5955f2355ed45f55986.1789741839.git.u.kleine-koenig@baylibre.com>
 <arD6ILv1sd8YBUXj@orome>
 <arEiVZG7UqxpqAPZ@monoceros>
 <arFVjZ7bE2-lgnqm@orome>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="agfmvsvuk6z7tqez"
Content-Disposition: inline
In-Reply-To: <arFVjZ7bE2-lgnqm@orome>


--agfmvsvuk6z7tqez
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/3] pwm: tegra: Make use of dev_err_probe()
MIME-Version: 1.0

Hello Thierry,

On Mon, Sep 21, 2026 at 06:14:31PM +0200, Thierry Reding wrote:
> On Mon, Sep 21, 2026 at 02:46:03PM +0200, Uwe Kleine-K=F6nig wrote:
> > [1] last instance was just today, where on a bananapi USB didn't work
> >     and /sys/kernel/debug/devices_deferred ended up containing:
> >=20
> > 	1c13000.usb     platform: supplier 1c13400.phy not ready
> > 	1c1c000.usb     platform: supplier 1c13400.phy not ready
> > 	1c14400.usb     platform: supplier 1c13400.phy not ready
> > 	1c13400.phy     platform: supplier axp20x-usb-power-supply not ready
> > 	1c14000.usb     platform: supplier 1c13400.phy not ready
> > 	1c1c400.usb     platform: supplier 1c13400.phy not ready
> > 	axp20x-usb-power-supply
> >=20
> >     It would be so easy[2] to add a useful debugging hint here
> >=20
> > [2] https://lore.kernel.org/all/b699f8251afed736af454a981630926e45eb7da=
7.1789983244.git.ukleinek@debian.org/
>=20
> I see. Yeah, I find it increasingly difficult to remember all the
> context of a function call, whether it is that it prints an error
> message or needs some lock to be held, sleeps or not. Sashiko has
> been really good about pointing some of those things out.

I guess a comment in the function docs would also already help me. And
an upside is that (I hope) Sashiko would understand such a comment, too.

Best regards
Uwe

--agfmvsvuk6z7tqez
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmq/byYACgkQj4D7WH0S
/k59hQf+OU1W9ZhedzdfcGj2U3UJ1x+P1RejoQ2RuQVfrUgHvC3MSMFk7JXsrDNc
LTbCJVjT8VU/Nob7KA4r+5v/UF17IVLwokxHP/bn7d8Btes8lHsvoPag6kfkWz8L
I5dGcmyYxf8HrpoB03TIu49HauvAcTcm45e1Y/7+FnUpZIJlfwGUlQWCaO6JAWNn
cH9sdSJQ9T7Sa40ARrWOP8j/O1KkVB7e5oQ+m6A9oCHaENvoHXbJqg1+NekVzb/E
nxHUjAeKvse/DRePf+hAuBmHHO3t+jsZQgfdGSzKfGRdiITlnAU6Plldbt/Ao/MI
aQpnnF06H0F/MWxjqxrMExhYMLOHiA==
=Wsri
-----END PGP SIGNATURE-----

--agfmvsvuk6z7tqez--
