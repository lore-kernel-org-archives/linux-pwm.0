Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCDA37E5CA;
	Wed, 12 Aug 2026 19:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786563886; cv=none; b=HynsioUIigfkTaq8Np3N8mA0tmnMfkkH9s8OmirVXLRfaj5UhMVx2eE1u6bgdhUdUJrHa+T82Vo3ZCfG/uUiDJRwoN0aQ80k++Ol+mVA19mAcsEgSGsFKvhttsdJ8YnAEdpT6Hyt5wULYiSjtzq3WaNt58YGv9tN/hI7OnCHON8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786563886; c=relaxed/simple;
	bh=U3TGCPVC2yy3il+YKuGpp732RYB6TSQm8RVz0RS5uCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sW7qVQDD0j5MDk8BzPNQVbanGSXbrFhKhJV+vDLV8hBJpsD+ucyKhGpQaPcgOf5DsGBZsKWThh2NnBwUr7CrKjzG1bV+gZ9OekpwjXI+I3pt9JjUSMMBJ578sl7j8uLQy2KeZqXDwzPIvl1BvdrfajC0U54SAz5GzQQ0yAXyEQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hevFYgBe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hevFYgBe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80381F000E9;
	Wed, 12 Aug 2026 19:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786563885;
	bh=uRG41YjUcntiKwh1UKbqg1nGoAcrQJFvwoaaCU2YtPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hevFYgBeDxy1TCdmZuiADLNDGERXJTwfSV2iWbeOixOGpv5mRFg88g8utzrvP4uvj
	 tqtCQqe8FuBh+gAeV0V7qV4F1/aKy0dHSL/zMlyABixTEGV/MkdjSImzA1xeCmbg1Z
	 Z4w5nhknJ7vsAeTjsxBg4E6L96jDv+QGsSu1d1qkOwpxh2I+WzKDLCrdQ6544cfoWM
	 XJ0ee+kKXXwPAvW96gh4fXW7RLZ73454H5f7Bqe5/A0vsvfIeAc9WxynITiq0KfWcM
	 k+mYfIdRXaS1Ejb1k5+6ZC54pLMLktdHJtMUXo2snfJRSrOHPydMUiGNP6+jf+rs0Y
	 KMbhZSh7ZJKxA==
Date: Wed, 12 Aug 2026 14:44:44 -0500
From: Rob Herring <robh@kernel.org>
To: Eduard Bostina <egbostina@gmail.com>
Cc: daniel.baluta@nxp.com, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	goledhruva@gmail.com, m-chawdhry@ti.com, linux-pwm@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	simona.toaca@nxp.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: pwm: Convert TI PWM Subsystem to DT
 schema
Message-ID: <20260812194444.GA693080-robh@kernel.org>
References: <20260812094420.1057067-1-egbostina@gmail.com>
 <178656332725.687853.3345749883291406683.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178656332725.687853.3345749883291406683.robh@kernel.org>

On Wed, Aug 12, 2026 at 02:35:28PM -0500, Rob Herring (Arm) wrote:
> 
> On Wed, 12 Aug 2026 09:44:20 +0000, Eduard Bostina wrote:
> > Convert the Texas Instruments SoC PWM Subsystem bindings
> > to DT schema.
> > 
> > During the conversion, the following updates were made:
> > - 'counter' node was added to the allowed child nodes
> >   list to resolve dtbs_check warnings. Some eqep nodes
> >   use 'counter' instead of 'eqep'.
> > 
> > Signed-off-by: Eduard Bostina <egbostina@gmail.com>
> > ---
> > Changes in v2:
> > - Renamed the file to ti,am33xx-pwmss.yaml to match the base compatible.
> > - Required a 'compatible' property in the child nodes.
> > - Reduced the binding to a single example and included the PWM child
> >   nodes (ECAP, EQEP, EHRPWM) in it.
> > 
> > Link to v1: https://lore.kernel.org/all/2026081109d-up2208.687731-1-egbostina@gmail.com/
> > 
> >  .../devicetree/bindings/pwm/pwm-tipwmss.txt   | 58 --------------
> >  .../bindings/pwm/ti,am33xx-pwmss.yaml         | 76 +++++++++++++++++++
> >  2 files changed, 76 insertions(+), 58 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-tipwmss.txt
> >  create mode 100644 Documentation/devicetree/bindings/pwm/ti,am33xx-pwmss.yaml
> > 
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

Withdrawn. Your example is incomplete.

Do not use DT_SCHEMA_FILES to test. You can do 
'make pwm/ti,am33xx-pwmss.yaml' which is a bit more complete of a test.

Rob
