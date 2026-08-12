Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BF133065D;
	Wed, 12 Aug 2026 19:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786563330; cv=none; b=kI+IGI5mGSqIDPQ2Kb6a3ZHN79ybG9O6Qrl7tQtY6iGURoXZkOY/Oglb9xjQuz1WjHMud/Bd1OXL5djzTlAJqs3IQ0bDOepq3jZ3pt3+Hn8870zjocDeV1tJMEdHbhAu2gg0LQUifnXMYARNxWqGVV7V+BbwfKQi71aLHNOVBuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786563330; c=relaxed/simple;
	bh=JGZSnYOfuNZ8eVAHEi9Fqf9c42TTATmF/hhASYFMEOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XiF93a5CEiywoHfxwN/Rk4RRgV+qGlurb5RAx3+k6fM6xofQQKatsGFwA985aRIpR8+9/j1SzT4CGD97JxRT96JYKG21FuWvKZgZ5GNer/wSJO8Bo0MCIyb7ClLNbyI/80DtZ5dQ/XeruapM0ctjDj454hvNTN8mSxIFmhIuywI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KgU+rsMu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KgU+rsMu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5BF1F000E9;
	Wed, 12 Aug 2026 19:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786563328;
	bh=MvIkuUI+DCPA393UB0ZOeqbfhArj5fNyzVWcHpeAZpY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KgU+rsMu7mITPTdXIAvYcVGvZVGgK05nhfnamyleZZfjxfMB9xixAdHjayPWTt0YB
	 tbD3cWQSVAFtYQPJ3FAW+5FpX1ZohK8eHq0aZEepmnDcrsogkeDeSzEupP0a75RhDe
	 CieieTjBNHSKQorKI64Io9YYx5mUbECBPo4/cBuggHdrBrGjLeN9VjeiDQD7VjA0kp
	 LXTBG1h9x6lFUqXyOAAsDOeL71dR/MBasHaYAGiAw/NKUPFZTfoP3HWjIiuyd/yjKb
	 5ZnIPrlpxLEmo4RpCrHqF2REuw8d0Bq9euLG7MBLrcvAe6JBqMyytcrmGbDpwPaxHR
	 PPBEQA37lOsYQ==
Date: Wed, 12 Aug 2026 14:35:28 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Eduard Bostina <egbostina@gmail.com>
Cc: daniel.baluta@nxp.com, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	goledhruva@gmail.com, m-chawdhry@ti.com, linux-pwm@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	simona.toaca@nxp.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: pwm: Convert TI PWM Subsystem to DT
 schema
Message-ID: <178656332725.687853.3345749883291406683.robh@kernel.org>
References: <20260812094420.1057067-1-egbostina@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812094420.1057067-1-egbostina@gmail.com>


On Wed, 12 Aug 2026 09:44:20 +0000, Eduard Bostina wrote:
> Convert the Texas Instruments SoC PWM Subsystem bindings
> to DT schema.
> 
> During the conversion, the following updates were made:
> - 'counter' node was added to the allowed child nodes
>   list to resolve dtbs_check warnings. Some eqep nodes
>   use 'counter' instead of 'eqep'.
> 
> Signed-off-by: Eduard Bostina <egbostina@gmail.com>
> ---
> Changes in v2:
> - Renamed the file to ti,am33xx-pwmss.yaml to match the base compatible.
> - Required a 'compatible' property in the child nodes.
> - Reduced the binding to a single example and included the PWM child
>   nodes (ECAP, EQEP, EHRPWM) in it.
> 
> Link to v1: https://lore.kernel.org/all/2026081109d-up2208.687731-1-egbostina@gmail.com/
> 
>  .../devicetree/bindings/pwm/pwm-tipwmss.txt   | 58 --------------
>  .../bindings/pwm/ti,am33xx-pwmss.yaml         | 76 +++++++++++++++++++
>  2 files changed, 76 insertions(+), 58 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-tipwmss.txt
>  create mode 100644 Documentation/devicetree/bindings/pwm/ti,am33xx-pwmss.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

