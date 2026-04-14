Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FE22C21F4;
	Tue, 14 Apr 2026 06:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776146697; cv=none; b=l1IZQ/MLUtm5x/8awsq8kPySANHoxnJAQNUR5k/tVOmynoqQ2WcTU4sqUN0aw9X3mkkx98rpK/u34EJ+HTva23B988Ih0JTdcGpf/GxYufq6cejdwcXtstapa4YlHcElFwK+SlbWSkTonK/gaH9VZk32oiZmjxpYrdLxCTNW2uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776146697; c=relaxed/simple;
	bh=l6iBfcudaZxGwh852DmRi0hqjipK/40+/a0KJ/CaPyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IrYf5OcCkLTqLu9n9Fzl09Pz4AAbZwJRkR9qjV0yHd8e+We2dQQRLuzREzt51kuzIpUKBnvvWbiZ1g9xdgb7de2Wpgf1lGEBZCZz/g4PYsnDWmJMVeYznmka3F4iNBs+tJdTedRyGX51a0q7+oCf5VyfYhZrsGePg/oLyc9kedI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tkYJbgrc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tkYJbgrc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63420C19425;
	Tue, 14 Apr 2026 06:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776146696;
	bh=l6iBfcudaZxGwh852DmRi0hqjipK/40+/a0KJ/CaPyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tkYJbgrczCaFmWG7KuMw4rMZsZ3tEH+yUIbVhVyTfBIVmOh+3LqxmxCJBIo2oPJYw
	 Xht/EvbxkeJv5tGcJxZxtofyd6SZhbTXyc0eSk1okQ1OADs37rMEOcrHCgE3Xca5qA
	 R71ORwt0WTwOy3MvQixkRwIDHFpGYbs7+ku34IdONQdifs1nr+JXzBonhaOwYJzTNT
	 qrf13IZ+FqGfVXTZUIWObDTi78ZAQxAz3aGeYlbN57PAVGKjRTY/NWMycYgBxccoMP
	 +C5I0ujLEDV/BNqWWNJ2rbwWJaM17EnRpOXPm5kW3SDtY3CN1X6jNy/fi8f++sNVVe
	 EqS/CiwnNHBMQ==
Date: Tue, 14 Apr 2026 06:04:53 +0000
From: Yixun Lan <dlan@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Duje =?utf-8?Q?Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev
Subject: Re: [PATCH 2/2] pwm: pxa: Add optional bus clock
Message-ID: <20260414060453-GKA203300@kernel.org>
References: <20260409-03-k3-pwm-drv-v1-0-1307a06fba38@kernel.org>
 <20260409-03-k3-pwm-drv-v1-2-1307a06fba38@kernel.org>
 <adyq-Uckwwe9uACA@monoceros>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <adyq-Uckwwe9uACA@monoceros>

Hi Uwe,

On 10:38 Mon 13 Apr     , Uwe Kleine-König wrote:
> Hello,
> 
> On Thu, Apr 09, 2026 at 12:45:12AM +0000, Yixun Lan wrote:
> > Add one secondary optional bus clock for the PWM PXA driver, also keep it
> > compatible with old single clock.
> > 
> > The SpacemiT K3 SoC require one bus clock for PWM controller, acquire
> 
> s/one/a/ ?
> 
Ok

> > and enable it during probe phase.
> > 
> > Signed-off-by: Yixun Lan <dlan@kernel.org>
> > ---
> >  drivers/pwm/pwm-pxa.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
> > index 0f5bdb0e395e..2ace31405c2d 100644
> > --- a/drivers/pwm/pwm-pxa.c
> > +++ b/drivers/pwm/pwm-pxa.c
> > @@ -53,6 +53,7 @@ struct pxa_pwm_chip {
> >  	struct device	*dev;
> >  
> >  	struct clk	*clk;
> > +	struct clk	*bus_clk;
> >  	void __iomem	*mmio_base;
> >  };
> >  
> > @@ -177,7 +178,12 @@ static int pwm_probe(struct platform_device *pdev)
> >  		return PTR_ERR(chip);
> >  	pc = to_pxa_pwm_chip(chip);
> >  
> > -	pc->clk = devm_clk_get(dev, NULL);
> > +	pc->bus_clk = devm_clk_get_optional_enabled(dev, "bus");
> > +	if (IS_ERR(pc->bus_clk))
> > +		return dev_err_probe(dev, PTR_ERR(pc->bus_clk), "Failed to get bus clock\n");
> > +
> > +	/* Get named func clk if bus clock is valid */
> > +	pc->clk = devm_clk_get(dev, pc->bus_clk ? "func" : NULL);
> 
> A local variable for bus_clk would be sufficient.
> 
Ok, will do

> I'm not sure, but I think passing "func" unconditionally to
> devm_clk_get() would also work fine.
Passing "func" unconditionally, will break old compatibles(not k3-pwm), as only
one clocks property is provided, but no clock-names property

-- 
Yixun Lan (dlan)
