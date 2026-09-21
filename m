Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5819E3BE627;
	Mon, 21 Sep 2026 18:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790014718; cv=none; b=NIL+vY5LzF635y/YwrmfE0ENhC2ShRD2sIhHwD8rJqpQPNK+o9lcrQV9DubWy8aNQZpU1yweoAFd1qvFJOHHmHSHspuc3h+8JwY1jbsS3XOKrXD2m7mzLofSzzACT098YErgjIaS30dMPI7fWbC2qFIzslIAAqQ0NwecbjQCnYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790014718; c=relaxed/simple;
	bh=Oo89vx5yydQGIL1iDyz/B0YNMuq7l9nfmGbOSCJaWew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HjapUI/KNiJT6737qEiV2BtG9dvQ0paw/qoEcoJGJ9qrkR8D1GeL3H6MgwHCxcp4V2Wl5CRSaegJilQ39PBfu4boaS0Hw2ePJfe3btCR86sXStdcm0pAM85bK6QhZysWq5yXkASymVCW86OlgiJ1+d3AE2LTEdh/+FmLu/5jNR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4Zq7HUJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4Zq7HUJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B771F000FF;
	Mon, 21 Sep 2026 18:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790014717;
	bh=y3MmTN1WCD1kBfJ5XE9TLBBrKPVz6WjoZ7nFhMOitjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X4Zq7HUJRxh5B0hjjKPecA0hoM3MqF0UDwMAyPRVVl/lmady8eL/qvHriDScs/xdi
	 piIdLTuIOk5gWgXXz037qmed+6js9U4EP9MXJdWOO1WizH2N0RCqxNR90oobb2XE15
	 kGZVCWNOhazNDkGqeN3P98hv4n2g7G5o2JmdqLsk/F/HfWjflmOi6ers3b7X/QN15d
	 iaU8DBa7F+wKU7ETSJe1cVkeBQPxp19zd1IwtjqWeZeNOMEbg63/g/qrNdHJMHr4D/
	 OamlFuHUzT6zzUXmMlNVkb5biEIFK1YmSBcBXoPCMd10TowjkKf9eVtmGCyhZR3uW4
	 +bETFCJdlUlaw==
Date: Mon, 21 Sep 2026 13:18:34 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Quchaosheng <quchaosheng000406@163.com>
Cc: linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, mfd@lists.linux.dev,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Subject: Re: [PATCH] dt-bindings: mfd: convert lp3943 to DT schema
Message-ID: <179001471344.1208214.13809098512770141099.robh@kernel.org>
References: <20260914013752.394579-1-quchaosheng000406@163.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914013752.394579-1-quchaosheng000406@163.com>


On Mon, 14 Sep 2026 09:37:52 +0800, Quchaosheng wrote:
> Convert the LP3943 MFD binding from free-form text to DT schema.
> 
> The LP3943 is an I2C LED driver that contains two sub-devices,
> lp3943-gpio and lp3943-pwm.  The GPIO sub-device is already covered by
> trivial-gpio.yaml, so only the PWM sub-device needs a schema of its own.
> 
> The PWM schema documents the ti,pwm0 and ti,pwm1 properties that select
> the output pins for each of the two internal PWM channels, matching what
> pwm-lp3943.c reads through of_property_read_u32_array().
> 
> Both schemas pass dt_binding_check.
> 
> Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
> ---
>  .../devicetree/bindings/mfd/lp3943.txt        | 33 --------
>  .../devicetree/bindings/mfd/ti,lp3943.yaml    | 64 +++++++++++++++
>  .../devicetree/bindings/pwm/pwm-lp3943.txt    | 58 --------------
>  .../devicetree/bindings/pwm/pwm-lp3943.yaml   | 80 +++++++++++++++++++
>  4 files changed, 144 insertions(+), 91 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/lp3943.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/ti,lp3943.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-lp3943.txt
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-lp3943.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

