Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC99548AE1B;
	Thu, 15 Oct 2026 10:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792060044; cv=none; b=uP+AqTfNPpmZ+GNN7CkBde2CNUT/Wt8w4s0Sc66u/uDZUqS67R7OMUv9FGTktMXKPYf2fJmeRNq0Ep95Rk3Gb+72sfI4bYE8v5pZIFQ6rHDw8QngoCtjWAlYW52IwDcoSFcWaUnnVuLZljEaXIIOd8diAKJZpZbymD8i40NClXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792060044; c=relaxed/simple;
	bh=/pmYFn6zvtg65n/LRagsFD1DUQ/dRzO+djamzOQldVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ujwo6DzEEvkAbku/y7lYSNMPjuoX2ek+gtcPD/i/f7O+/HhTEif6b28KbTUevQujKw/CUzp0+/VnLP6C+VP8P7EWUnmaUXYSWUODzxOzqPA08IrVDl0+qV4GG6KqWS6Mnrbxg3j7HOBIv+ibnGi22rK/ZAPHMVV4GRjJU+tonUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StbseA9x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StbseA9x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A510F1F000C4;
	Thu, 15 Oct 2026 10:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792060043;
	bh=/pmYFn6zvtg65n/LRagsFD1DUQ/dRzO+djamzOQldVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=StbseA9xux3foYF5yPtH9XAZidusm8q96oX4WaO31F+gaODduDrdf4zzGf0YF4UCe
	 mM4m0o4t0Jc7ES+hWA9VxKtv0L0nx4MeHX8irb/+I7MsCysbWJlfN0oVT10s9FC9+T
	 QDxC1b/rcKXsprpZC4pVjJPanTRFc0/ABG5e7FHPhJBvY4NOGx/+ciHfzOPlTWQSbX
	 /UlBoq+MDEdewJne66Gb9qq9i9vgg4YmwT7R+oFjKpapKtZSdtP4Zj4yK7K8J7MKXu
	 X9ReuCpt4zeeBSnReATh7Cw/cn8Q53jjcATRbyB5h0l3HSzIAV6S08qsvHrjT/05mm
	 RpI1ZbBTFLZKA==
Date: Thu, 15 Oct 2026 12:27:16 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Hal Feng <hal.feng@starfivetech.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor@kernel.org>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <pjw@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v23 1/2] dt-bindings: pwm: opencores: Update compatibles,
 examples and maintainers
Message-ID: <20261015-poised-modest-leech-4decf5@quoll>
References: <20261014110429.52762-1-hal.feng@starfivetech.com>
 <20261014110429.52762-2-hal.feng@starfivetech.com>
 <9c0737d8-455d-4025-8482-950b64029f35@kernel.org>
 <atCos9UIaZoRs4N8@monoceros>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <atCos9UIaZoRs4N8@monoceros>

On Thu, Oct 15, 2026 at 12:20:54PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Krzysztof,
>=20
> On Thu, Oct 15, 2026 at 11:01:29AM +0200, Krzysztof Kozlowski wrote:
> > On 14/10/2026 13:04, Hal Feng wrote:
> > > Remove the jh8100 compatible since the JH8100 SoC has been canceled a=
nd
> > > will not be released.
> > >=20
> > > Change the register size in examples to 0x10, since an OpenCores PTC =
IP
> > > has only 4 32-bit registers: CNTR, HRC, LRC and CTRL.
> > >=20
> > > I will maintain this pwm module in place of William.
> > >=20
> > > Tested-by: Maud Spierings <maud_spierings@hotmail.com>
> >=20
> > Drop, did not happen. Is it so tricky to respond to the one patch here,
> > where the tag would be applicable, instead of replying to cover letter?
>=20
> I don't know what Maud did, but if they checked that the various dt
> linters are still happy, that doesn't deserve a Tested-by:?
>=20

No. Why would compilation be called testing? Since when? I also compiled
driver and the other code, just like every other boot did, but no tags
for us...

Best regards,
Krzysztof

