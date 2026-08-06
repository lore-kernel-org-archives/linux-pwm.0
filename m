Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BAF2BD022;
	Thu,  6 Aug 2026 10:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786012883; cv=none; b=hbPBC9wotgvGj6Yj8poziVNzBZSc6auwo9zofIgo6xNSrFYLDK6dGY+0hJKbLylNX6rMFOKlw2ymH0E7D74hWLWgAJq1avfVfznpHhfubMAgLlBvdu99rH8EtYNHkkZxKx5M4CCLxykBLeYJAC7VUK4n9g+DsL4lm+jjgXlYcLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786012883; c=relaxed/simple;
	bh=E3mUvGGsmcep0mgPUCVT6cbHctKMdABAbGyPTrYbzgc=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=hRLK0aGgzLHkufBmHE4zAZ2Y4/KhinuDSXFFXTmBgpBWOOhfCC5pgfEOFfhj1Eg4mMODTkjGBAGONC2voi5MphFm8yif/wJ7aUZ7twaXJxdNJullzD2gbmZFtM3GXKZoBXuXS1j/tToNFYgryDlJ7m3W0VNQb+47yiR7cH4nYwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LOVpehUx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LOVpehUx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCDB41F000E9;
	Thu,  6 Aug 2026 10:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786012882;
	bh=tFv2iJY7nFCn3LAnBmQhdsOf0WSz+DzcRO1lvKl2Q2A=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=LOVpehUxOOI0m/Jyi4E4q/irl+rgL0EGvfyDGvkfnioyBMD3G2NkRRLu6bWS2CcmE
	 2rnVXbnMghyrkb5qNzt7ngA4HKgavgRiVdFoKi4WC1B7WZCyPPAlnnejk7Pk1Bs1qd
	 elXzOLQ37I+3qYLyQW1EPXjj5dDNsUdUjv1X9ccTFjBSCKJ9LZEnVCs7HvobwSwlcL
	 KizhiraQ8n8cL6rQ+mX9dfvqGe/5HvqCBPY7RscYq4cMC3vMsEiur6gRxyRfxawbin
	 aCqvP9HYXFBC0w4w3YwZ1QK9wpyA2AOdNd1TnjtzHB/XnWG7XKoU11j4EIJuZ0EKLe
	 hVRWJvp2J4WKg==
Date: Thu, 06 Aug 2026 05:41:21 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 linux-pwm@vger.kernel.org, Harshit Shah <hshah@axiado.com>, 
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Prasad Bolisetty <pbolisetty@axiado.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>, 
 Guenter Roeck <linux@roeck-us.net>, Karthikeyan Mitran <kmitran@axiado.com>, 
 Tzu-Hao Wei <twei@axiado.com>, Akhila Kavi <akavi@axiado.com>
To: Petar Stepanovic <pstepanovic@axiado.com>
In-Reply-To: <20260806-axiado-ax3000-pwm-fan-v1-1-f6db4cf2166b@axiado.com>
References: <20260806-axiado-ax3000-pwm-fan-v1-0-f6db4cf2166b@axiado.com>
 <20260806-axiado-ax3000-pwm-fan-v1-1-f6db4cf2166b@axiado.com>
Message-Id: <178601288105.794443.11219080206181724677.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: add Axiado AX3000 and AX3005
 PWM fan controller


On Thu, 06 Aug 2026 02:01:29 -0700, Petar Stepanovic wrote:
> Add a Devicetree binding for the PWM fan controller found on the
> Axiado AX3000 and AX3005 SoCs.
> 
> The controller measures fan speed using a hardware tachometer block.
> Fan speed is controlled through a PWM signal supplied by an external
> PWM controller.
> 
> Add a MAINTAINERS entry for the binding.
> 
> Signed-off-by: Petar Stepanovic <pstepanovic@axiado.com>
> ---
>  .../bindings/hwmon/axiado,ax3000-pwm-fan.yaml      | 68 ++++++++++++++++++++++
>  MAINTAINERS                                        |  8 +++
>  2 files changed, 76 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/hwmon/axiado,ax3000-pwm-fan.example.dtb: fan@33001400 (axiado,ax3000-pwm-fan): reg: [[0, 855643136], [0, 1024]] is too long
	from schema $id: http://devicetree.org/schemas/hwmon/axiado,ax3000-pwm-fan.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260806-axiado-ax3000-pwm-fan-v1-1-f6db4cf2166b@axiado.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

