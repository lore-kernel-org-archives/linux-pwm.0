Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DFE31E848;
	Tue, 23 Jun 2026 17:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782235934; cv=none; b=W+AbgKaq/PDyicL8uFJQBArXFQUvZwNs88lwFdyz+5kDk3LSre4u9vgkP6uEJ52YleAH3YsfGf2Dz4o70UN52Ds4WQMXZzjz2C0Fvi/kdVHNPRToVWMX0m6SNb4q6qBVk0jOl9TGj/QzH/UqvpHSkUOkgBeonQwjXc3IiMWwpDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782235934; c=relaxed/simple;
	bh=mEHtEJfSVvPRo0FiAoWZg0wyxCt307pleMeuVDIuBVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJK1KzFf1dl4SDAZWh+ceBYjvm9Xbv4gvoH9Qc5wUJqX3MK7BskDvvQstl8GMlTXtZMdNElMTeC1Yhx81sZS/y3Vfc6S8xfj7OpuQECsu0A+OUC0yaYszuGr2DYEa+NABcQmNO3s7OT8dHpQhkCIfXEHHH5akHDclqAEl5EbL+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIBGXa6V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIBGXa6V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 468D21F000E9;
	Tue, 23 Jun 2026 17:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782235933;
	bh=mEHtEJfSVvPRo0FiAoWZg0wyxCt307pleMeuVDIuBVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lIBGXa6VqKMV/lKmzJkqQbiD3ezaGzFeDWtt3TBm1AL5R/o5P2b1TRb9SFtA1qpjn
	 nzd47yHxR62EAj8AhwFFTi1VJr6Pnbdrziub+aUcr6MwUbuFc88DHcZn25IJjut7FP
	 WO06Q1HNvp8+Ck3ggWClR74Zh3rStQFW5fa+RbCUY8xad6B530WQFF4A3in4T9YdBP
	 ZRxGw/ZNsv6ID1xsQAzGkUtwKx2ZKHVBqXjbf6JVgz1d/0l2Bd9p3YRp26NL2BL2ht
	 BeVHHlAroGA5WYao+UURpc/jZLZTbeQQLIDL1u7UkdizIhPn2Pfpme21EV8Ia7DCvH
	 iH7d0P3YocYPw==
Date: Tue, 23 Jun 2026 18:32:08 +0100
From: Conor Dooley <conor@kernel.org>
To: dongxuyang@eswincomputing.com
Cc: ukleinek@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ben-linux@fluff.org, ben.dooks@codethink.co.uk,
	p.zabel@pengutronix.de, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	xuxiang@eswincomputing.com, wangguosheng@eswincomputing.com,
	pinkesh.vaghela@einfochips.com
Subject: Re: [PATCH v8 2/3] dt-bindings: pwm: dwc: Add eswin compatible
Message-ID: <20260623-etching-boozy-8775b1f1554f@spud>
References: <20260623071329.2034-1-dongxuyang@eswincomputing.com>
 <20260623071438.2147-1-dongxuyang@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Pc5d/wXxWbfsACVj"
Content-Disposition: inline
In-Reply-To: <20260623071438.2147-1-dongxuyang@eswincomputing.com>


--Pc5d/wXxWbfsACVj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--Pc5d/wXxWbfsACVj
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCajrDGAAKCRB4tDGHoIJi
0tpQAQDyYKTzDauf8ZG938t4/xbFS79vxmq28F116fHcXh7UygEAwUboEJCIzgvw
O1LLfrxCZxcCMtcZtniXyzTnHNrM/gE=
=ecFI
-----END PGP SIGNATURE-----

--Pc5d/wXxWbfsACVj--
