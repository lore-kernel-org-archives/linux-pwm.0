Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36C02EDD40;
	Sun, 30 Aug 2026 20:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788120769; cv=none; b=Wn8EiB7qy+gjNj5046KPMpjjAr5A3WCVlUmTQOm8QE08NRz8DeMhNrr7meA3adbCTWxMLXswUhODTZqzIdwvebcsK8LtnSt8QbdhAqfIqb5sfctdOXV6cEDcIBq4Ehmx7uEAg4oVD+ivz9tFMGwQ6z6+ryrrVwSq0JisxN6Hre0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788120769; c=relaxed/simple;
	bh=DbxFAIkLw05e2oIsuNlzlx57pu5ctS8/WZa4nesiB8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g22Bm47nSVbJRM7ASX8DxslsX/vhXiL9GLia5wy3j1kzeCb0bAkJQGrSHqJyueAqlCKVQZUJyvgax7t5qGwNkVaR6nFUiyyiZEOvV3966Yb/+6AXtN+ZV65wqvkdUGCtv8QctlSa4/BJ0PG67lDZdr6CwRWOl3/Z2wuNKGmKmrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbBGgQxW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbBGgQxW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B901F000E9;
	Sun, 30 Aug 2026 20:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788120768;
	bh=S8Q3Gfv+n2T6K+nlbHNH6sMhB6bBZJQj9yV58dYw0aY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gbBGgQxW9bkOe23wBpcWj6gTwlKHAzKaGzqFbwy8CtOAVOb/Sd2cmobx0N2NxaN9Q
	 iuQOac6vEX3hd/P/AmsUUg4Xqr2iCMd/qc+mgKZuEBUmznKNlzjeS1oACXbztidDT5
	 z8Fm+0OB8lGRbae0RsuQtzpIIkVy8iry9heOYqysmHNtorp3/fi0no6csAdkLsrowO
	 6gY9UUEWV8jwEpgp6EM/c5XMpLJfGLcyPCUuH/ByfgB0Mfkl4PerOvh7JPZOA97FVZ
	 JFRGuvFO2wJhruJaWrrJV5sBYXYca3kbTi5jt0qhCdrxJV3wQ77frx5fNDq2BTGSwH
	 VXuYch0OcF7Qg==
Date: Sun, 30 Aug 2026 15:12:47 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Eduard Bostina <egbostina@gmail.com>
Cc: goledhruva@gmail.com, simona.toaca@nxp.com,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-pwm@vger.kernel.org,
	m-chawdhry@ti.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, daniel.baluta@nxp.com
Subject: Re: [PATCH v3] dt-bindings: pwm: Convert TI PWM Subsystem to DT
 schema
Message-ID: <178812073136.303655.5714734654736735562.robh@kernel.org>
References: <20260815074817.2117916-1-egbostina@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260815074817.2117916-1-egbostina@gmail.com>


On Sat, 15 Aug 2026 07:48:17 +0000, Eduard Bostina wrote:
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
> Changes in v3:
> - Completed the single example by adding the required 'clocks',
>   'clock-names' and 'interrupts' properties to the ECAP, EQEP and EHRPWM
>   child nodes, so the example passes a full dt_binding_check.
> 
> Changes in v2:
> - Renamed the file to ti,am33xx-pwmss.yaml to match the base compatible.
> - Required a 'compatible' property in the child nodes.
> - Reduced the binding to a single example and included the PWM child
>   nodes (ECAP, EQEP, EHRPWM) in it.
> 
> Link to v2: https://lore.kernel.org/all/20260812094420.1057067-1-egbostina@gmail.com/
> Link to v1: https://lore.kernel.org/all/20260811092208.687731-1-egbostina@gmail.com/
> 
>  .../devicetree/bindings/pwm/pwm-tipwmss.txt   | 58 -------------
>  .../bindings/pwm/ti,am33xx-pwmss.yaml         | 82 +++++++++++++++++++
>  2 files changed, 82 insertions(+), 58 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-tipwmss.txt
>  create mode 100644 Documentation/devicetree/bindings/pwm/ti,am33xx-pwmss.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

