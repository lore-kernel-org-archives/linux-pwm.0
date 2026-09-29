Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCBD4ED1A1;
	Tue, 29 Sep 2026 10:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790677149; cv=none; b=T7n+2KsjCquDvwQwdzPIzLpjl+V6x/yPIWEx9mkY3V7S1y3OyRoqW2JkS6bvKezfM0t5NBg8zC68oIpr3woVBOROKfMfbqWwZe2pR6lHR1DPqfA9iXUn6LcUYzk9WnmfLBPhrw+08tw0AcQeNbt4DLUQd/Rk22uzh5BOk43Ai9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790677149; c=relaxed/simple;
	bh=4Ty815WRXMLUa/jA8uK1KWIIDg2C5Eefw/FpCCiBNp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bSoUSpKFt+v/EL0WinoWtPB+ori4cO3kIlhuRBXyEdIBbHsClGP1T/TZTZFN/r619PUzaOFYbJd08bbsVahcsaoYhRhmUEdnDE6m5mUxwGVQ0Bf8pZZwJ/LLrtJQGsNZbOLUbS4sGly+undbsLsjoLIruhym3BYSxSQgS/9ITCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZBp1qng; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZBp1qng"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D727C1F000FF;
	Tue, 29 Sep 2026 10:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790677143;
	bh=woeQLwJ8zy/nxVZgjqm/ZAltmJh8LE7sLrIC8/Tt350=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SZBp1qngjocFHQgDiYcdRimMUuly/gj9OKiZuPzKVlvIWH4FLxMFj86coU+QnMBT1
	 zkxqqhAn7Bqif3RFQUJ1SMcOeQVJUj10Pjhbb/pKnO1ozty/6+J4RtYIG0gxP0iIG0
	 boJcKf8+12/D7yPrkRKqYQtQktbS8JIXAAGa+oydhU9TpW+84XEIhWBk+rRepPaMNz
	 g9StLQXazmOS5MYSrTm3Uf8Bo6/l1CnrpG1rxT0caFEt2ZrqvKmDZOK97yhCHX0+9c
	 cbgnYlUeD2bxH4dpI2HVJ91do5NWvziXygfGARSXdrlrkWTn6u8Xu5HGZgz9/tjt5C
	 2jN+V9koogcxA==
Date: Tue, 29 Sep 2026 11:18:59 +0100
From: Lee Jones <lee@kernel.org>
To: Quchaosheng <quchaosheng000406@163.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	devicetree@vger.kernel.org, mfd@lists.linux.dev,
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: mfd: convert lp3943 to DT schema
Message-ID: <20260929101859.GF2112133@google.com>
References: <20260922061907.56372-1-quchaosheng000406@163.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922061907.56372-1-quchaosheng000406@163.com>

On Tue, 22 Sep 2026, Quchaosheng wrote:

> Convert the LP3943 MFD binding from free-form text to DT schema.
> 
> The LP3943 is an I2C LED driver with two sub-devices, lp3943-gpio and
> lp3943-pwm. The GPIO sub-device is covered by trivial-gpio.yaml, so only
> the PWM sub-device gets a schema of its own.
> 
> The PWM schema documents ti,pwm0 and ti,pwm1, which select the output pins
> of the two internal PWM channels and are read by pwm-lp3943.c with
> of_property_read_u32_array().
> 
> Assisted-by: LLM
> Signed-off-by: Quchaosheng <quchaosheng000406@163.com>

You should use your full name for sign-offs.

> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

-- 
Lee Jones
