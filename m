Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755423ED5C8;
	Thu, 16 Apr 2026 19:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776369240; cv=none; b=uGmirUFfhAN9w+LgVK4GPbi0WW+2+sbzjS7KyfKwqute8ypuu1AWQkcti91voEZ7dMKI66LEeoCTXRU8ftHSVQ7jSGQc3jOcn6yhEdpVUMoOoLKpq36z0ueMclU6TGcUbfNvVi07T+MgUf2P6PadiluNfsF7UNy2x3wMnj1fKd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776369240; c=relaxed/simple;
	bh=bdrgUpLv4Yx4lHu+3+pqe3aRgMPAEQa18wcoOo5mqdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JKhbOgwcZRxXvN0tJ6tM0UkltoM6uPQl4j2uEjPzJBau1jov04FvQN2x7einqFwL4PaRfEwIVlbgwoDIGzWQPVRyAHy8b5JuUwbkf11sXNTSZ9ZK86CHr8AqTq0lrDsQaUSdQ6os1pTBj4qvjiwRX7rLR4GzOV3+/HHwgCiXSPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDb2lX/u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDb2lX/u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DDB8C2BCAF;
	Thu, 16 Apr 2026 19:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776369239;
	bh=bdrgUpLv4Yx4lHu+3+pqe3aRgMPAEQa18wcoOo5mqdQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cDb2lX/uFXCvwNxzod7p5xxzzlPzlI6GJPbjQ9VuMatEJgbgQ8W92/0k5/7laym6N
	 UVqQxGSGvm+48oztB/vFEEtE+wHXtsn5L9ZMjYQa1ohA0lreOPL8kYPlblbolLvJsR
	 BoD7dA/aaXbmT3A/aoMtgS3Xpou+zd0T3prlp1sNoi+DTGiME12azA8zC6kihZ9IaO
	 aKI7tyG47G0PE6cRU4YPv/ePg5NKhDlcQ/ibGbp2nYebURtEP+QWr05oF06FNmg2HY
	 JyR3VzqlbO1FUpTczew4I3VSZSqguukFutPNB8G0MWnmSekA2muh5udpLuMbY3PvRh
	 XKv976WY4vLwA==
Date: Thu, 16 Apr 2026 21:53:56 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: dongxuyang@eswincomputing.com
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	ben-linux@fluff.org, ben.dooks@codethink.co.uk, p.zabel@pengutronix.de, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ningyu@eswincomputing.com, linmin@eswincomputing.com, xuxiang@eswincomputing.com, 
	wangguosheng@eswincomputing.com, pinkesh.vaghela@einfochips.com
Subject: Re: [PATCH v4 1/2] dt-bindings: pwm: dwc: add reset optional
Message-ID: <aeE-D5vC453uqtm6@monoceros>
References: <20260415094908.1539-1-dongxuyang@eswincomputing.com>
 <20260415095020.1597-1-dongxuyang@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2u45m4lertypw5tb"
Content-Disposition: inline
In-Reply-To: <20260415095020.1597-1-dongxuyang@eswincomputing.com>


--2u45m4lertypw5tb
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v4 1/2] dt-bindings: pwm: dwc: add reset optional
MIME-Version: 1.0

Hello,

I suggest

	dt-bindings: pwm: dwc: Add optional reset

as shortlog.

Best regards
Uwe

--2u45m4lertypw5tb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmnhPlIACgkQj4D7WH0S
/k5StQgAuTx6lia9ofAcFhpDHln2LmLcS3WZ0H8ggZy1bqhM+5QDp0qSwazuObMa
xbDInbNl1N6pDgTYdao8NMaCoVBjoufST2g/BaxW2bnIvq3OgECHMK09+pW25YGa
/Zl0q35Sgh/qmP8ESTHBhqvbBcKKPjxmjBo8BrHWOsMxbfkjJmbElmZPl0F4yT1A
u0MLFqV5C44yWMDNUzqIKlEZQaYRuSDCjLQyW4su09F8omrL0JbfC/Fd+QOxj15w
kcyofJwq2NpiylDBbgQl8HSPpS3JpBIgGf5TnkzJMMP1dzrGgcjSGcn81cHD6zXX
mA7KIiMddfldiaEK6H9/mO4hwJyzEw==
=cqJh
-----END PGP SIGNATURE-----

--2u45m4lertypw5tb--
