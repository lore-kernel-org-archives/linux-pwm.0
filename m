Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D061922F5;
	Thu, 26 Mar 2026 08:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774514463; cv=none; b=ZxSDigvgprDlAdaGl+NyRZa9rDV2JCGSBGHv62u+LvuPzfWsdly/FUcxwkw7aSmds36/AuaC1cTUX3RflHeRd+r4XmsB6PwukLuCJKKMfGSYyCPSJkZWIkLHTl3a2s2cef9+UCzh23TcbxJv2C8WOf/KU8wfOJtgLKFa/ZyC0ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774514463; c=relaxed/simple;
	bh=0SAblPH1XqQLvGdcjAfRvzYQoMpv55rPMjM79Ead8qU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bP/liHLWNJ0gRDhs/d/Hkv1mGQcz97Bb2ild3enl4UKnGdgAhO+FDl9fQBaqJujTFsl3SVhPtRCqHRjIkivTyWDuGsg0KOFZyGNC5zVXLHNECNtgPZn+8cJzCGNEEfSU15qXVtZMvgAG5L1dALG8RLseJbF0XwR6LwCoc9DbWWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QT4bUVZS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QT4bUVZS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08C4C116C6;
	Thu, 26 Mar 2026 08:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774514463;
	bh=0SAblPH1XqQLvGdcjAfRvzYQoMpv55rPMjM79Ead8qU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QT4bUVZSZJt2iGbjA/8YCh+whQgc1RthrPG4RcNog4KZOUFY+y5GVyUjadAmuYCZA
	 wyIsj0ZoCczBmpEIAqDy/ZT5qf+8KtNMG7EGAzIlZhhl/3Exxg3qL8HaWvuOsJcXwV
	 roRahoskkiIwH96+zDYEv9pUuzIhGTBeINGnQmLzpnsW7fYfLq00J9K1Wd+SPyS6HB
	 w32be45mS3v9lrW0+KjkIvd1h1xasFnL4xMn9PbEWvJ/5U9u52seTj2Wkqcp4FuG/7
	 3Yzl8b14MJvL8RGNTQXii/bL64YSCfBzhZedMD/LpIJ79K6QiWTjgtmINaTmET28VY
	 yPNX1Lxq1cL7w==
Date: Thu, 26 Mar 2026 09:41:01 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Mikko Perttunen <mperttunen@nvidia.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH v2 1/7] dt-bindings: pwm: Document Tegra194 and Tegra264
 controllers
Message-ID: <20260326-lean-nippy-flamingo-4437bb@quoll>
References: <20260325-t264-pwm-v2-0-998d885984b3@nvidia.com>
 <20260325-t264-pwm-v2-1-998d885984b3@nvidia.com>
 <acPuMGhPw74roB1E@orome>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <acPuMGhPw74roB1E@orome>

On Wed, Mar 25, 2026 at 03:22:13PM +0100, Thierry Reding wrote:
> On Wed, Mar 25, 2026 at 07:16:59PM +0900, Mikko Perttunen wrote:
> > From: Thierry Reding <treding@nvidia.com>
> > 
> > The PWM controller found on Tegra264 is largely compatible with the one
> > on prior generations, but it comes with some extra features, hence a new
> > compatible string is needed.
> > 
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> > ---
> >  Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml
> > index 41cea4979132..15706d2a808d 100644
> > --- a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml
> > +++ b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml
> > @@ -16,6 +16,8 @@ properties:
> >        - enum:
> >            - nvidia,tegra20-pwm
> >            - nvidia,tegra186-pwm
> > +          - nvidia,tegra194-pwm
> > +          - nvidia,tegra264-pwm
> 
> I think this was lost during the earlier conversation we had on the
> split of these patches. Krzysztof had pointed out that tegra194-pwm is
> now a duplicate entry. I don't know exactly how it ended up like this,
> but I'm pretty sure what I meant was:
> 
> 	- items:
> 	    - const: tegra264-pwm
> 	    - const: tegra194-pwm
> 
> This mirrors the fact that this is in fact backwards-compatible with
> Tegra194 but also has additional features that we need the Tegra264
> compatible string for.

If the devices are compatible. You have quite a lot of differences in
the driver, so the question is whether driver will work fine when bound
via old interface.

This was EXACTLY explained in DTS101 last year. I really focused on that
because after repeating for few years and two previous speeches people
still claim compatibility is something else. :(

Best regards,
Krzysztof

