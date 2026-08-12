Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FDB36728D;
	Wed, 12 Aug 2026 19:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786562916; cv=none; b=CQ7wucTqAaJniGQ9lm54144gOXPKugn+EI+YfWY4/1QVhPkExFu7NrcdyLOzq/D+Vb1qNpIk4hdI0HtCFA4lfx9QWF+dcomhepNVK/+I19Q9D1rsIl0/pIywQ9KDBWkYHqKYUfftHhxhImLsd6ki8+LL+VEFDf/H1ZWfh3VB9KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786562916; c=relaxed/simple;
	bh=Nodc1poISzZwSd/dSurIGAysUrbHV0LqQc2SaO6STJ0=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=t/iCj8nCjWCCG4p/Ta5OSGB05KI/PccCwr9zwyr+C+8gEUJSpocDSSPEJKgMAiBcu2e/Q+b4pvynJJiD5TuGLmToNbGHN94/enZsSjCs+HnpTqPtWsMgs79piDpbakR5BekfXFrjScYBnxwYop+NWJNFt/lCPxo2lmjTIzmHIqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUuFXnK7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUuFXnK7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C07B1F000E9;
	Wed, 12 Aug 2026 19:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786562914;
	bh=K5CNn8aIVT29di1qS2FYGQcnlcCFvUTt1GoXcoHHt58=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=hUuFXnK7cKwV6HS4kBvAK4OrldF3ukvqu3+/bK3MyBvi/aAHtLGmmoLlBnPQamTdm
	 TuJTbIIopDLdWizXuu1004QLy5rYgvlOwIFYsnjdx6lQLLvUvR7xSJwuyVAEh9rxOA
	 n7AtbFmUsM3x/BH4pL6W0kLS+MOGKUGgFCjdqkZIpa+MnTfucTqr+GC+yKkMpOgJV9
	 kuZjqJzEPatNBD7uW8pt0DJsmTu9N0t2rne7DAqjZOS49s/sFnSPj7s4y5RzFCLhcz
	 lHFfJgzk0YXhau2X2aUTyAjbP/t5aNlteSPzhtG0u2LvLaa+DJ5sOBVnbqNNgtnhL8
	 ZpuibDis/P9QA==
Date: Wed, 12 Aug 2026 14:28:33 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 daniel.baluta@nxp.com, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 linux-pwm@vger.kernel.org, m-chawdhry@ti.com, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, goledhruva@gmail.com, 
 simona.toaca@nxp.com, Conor Dooley <conor+dt@kernel.org>
To: Eduard Bostina <egbostina@gmail.com>
In-Reply-To: <20260812094420.1057067-1-egbostina@gmail.com>
References: <20260812094420.1057067-1-egbostina@gmail.com>
Message-Id: <178656291274.677408.8543317562709598309.robh@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: pwm: Convert TI PWM Subsystem to DT
 schema


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

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/pwm/ti,am33xx-pwmss.example.dtb: pwm@48300100 (ti,am3352-ecap): 'clocks' is a required property
	from schema $id: http://devicetree.org/schemas/pwm/pwm-tiecap.yaml
Documentation/devicetree/bindings/pwm/ti,am33xx-pwmss.example.dtb: pwm@48300100 (ti,am3352-ecap): 'clock-names' is a required property
	from schema $id: http://devicetree.org/schemas/pwm/pwm-tiecap.yaml
Documentation/devicetree/bindings/pwm/ti,am33xx-pwmss.example.dtb: counter@48300180 (ti,am3352-eqep): 'oneOf' conditional failed, one must be fixed:
	'interrupts' is a required property
	'interrupts-extended' is a required property
	from schema $id: http://devicetree.org/schemas/counter/ti-eqep.yaml
Documentation/devicetree/bindings/pwm/ti,am33xx-pwmss.example.dtb: counter@48300180 (ti,am3352-eqep): 'clocks' is a required property
	from schema $id: http://devicetree.org/schemas/counter/ti-eqep.yaml
Documentation/devicetree/bindings/pwm/ti,am33xx-pwmss.example.dtb: pwm@48300200 (ti,am3352-ehrpwm): 'clocks' is a required property
	from schema $id: http://devicetree.org/schemas/pwm/pwm-tiehrpwm.yaml
Documentation/devicetree/bindings/pwm/ti,am33xx-pwmss.example.dtb: pwm@48300200 (ti,am3352-ehrpwm): 'clock-names' is a required property
	from schema $id: http://devicetree.org/schemas/pwm/pwm-tiehrpwm.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260812094420.1057067-1-egbostina@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

