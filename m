Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E845F38BF76;
	Tue, 23 Jun 2026 17:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782235949; cv=none; b=H9Yvk/rCpVHjbYvv9tsCuk02z2aDip1U7DC73Ph0B83h3/2Ui7ESGJeDBGeVNiwbSs+pC2TsjLe9/pqR3YHjBYbHL1oco6BSddpz+TdZwcpoxnclXp/UYQl+TYz2T88lY7cGwNxI4SXTxGggMoHUmIy1SGMKaDBKZb0sPwKtoNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782235949; c=relaxed/simple;
	bh=6pHI2h21h/f0l+QTuQ21jJEo1ameA+SbgzIQl+SKZac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8LxLYJ1imzeJdS7bAOG0CNHcTe6T5n/Bo3lCKpqJRqXEquyFeRyKGu3cFD78t3cwTJqBPiV4l2xaOTbdfQwmKI+4vl+8HLMlIMFIQdG953xS7TfwpjmWgY/QaeKfRfg8NQOAdDsM75gWCl4J7nbqFqgHrWm+gLzd2IBYkksNZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8yDl2GP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8yDl2GP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 745F11F000E9;
	Tue, 23 Jun 2026 17:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782235946;
	bh=6pHI2h21h/f0l+QTuQ21jJEo1ameA+SbgzIQl+SKZac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F8yDl2GP+Le+F7X38ti4dTVOQ1qiz9nSeAVQ0D08Vn+yr2LybaODNprZCTxz1qZcu
	 wynYalbYwEqM0VrHnmUZGQ4j/X5nhHhHTZngJVb5DBwkivVnVEJrmBjCgn/sMx7Zsu
	 UHzkNB8+xpLlafyEhHn5CDQu2uWOBhV5Z7jrrOM2lEWn7QFRfVkKxFtnwFrWC0leRe
	 +5Mdrg9LTgy3b5FXet8HIbufjo6I3uK4DWpJrhU+qw5tHQWgwlZ3e4CWEJqLS+DLOu
	 P6Savj87dgDAfWUD6XMj2uxhsyRGutLmaaFcv+LSApQQ1qmAsTqqs3xEOAORDBiue1
	 x0YWGR3WnEQ9A==
Date: Tue, 23 Jun 2026 18:32:21 +0100
From: Conor Dooley <conor@kernel.org>
To: dongxuyang@eswincomputing.com
Cc: ukleinek@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ben-linux@fluff.org, ben.dooks@codethink.co.uk,
	p.zabel@pengutronix.de, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	xuxiang@eswincomputing.com, wangguosheng@eswincomputing.com,
	pinkesh.vaghela@einfochips.com
Subject: Re: [PATCH v8 1/3] dt-bindings: pwm: dwc: Document optional resets
 property
Message-ID: <20260623-crook-irregular-cf0fde81649f@spud>
References: <20260623071329.2034-1-dongxuyang@eswincomputing.com>
 <20260623071416.2092-1-dongxuyang@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LfUtI92o4jKrWg3Q"
Content-Disposition: inline
In-Reply-To: <20260623071416.2092-1-dongxuyang@eswincomputing.com>


--LfUtI92o4jKrWg3Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--LfUtI92o4jKrWg3Q
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCajrDJQAKCRB4tDGHoIJi
0gX5APsFjqXPsUXfsMxgCo8CUgrQtIKK1lPthwShxwr0BZbvgQEA/crjz4FkF7k+
OA696pH9e8W3mDumoTbEtqAUvLqh8AI=
=biyX
-----END PGP SIGNATURE-----

--LfUtI92o4jKrWg3Q--
