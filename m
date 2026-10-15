Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AAC55C30A;
	Thu, 15 Oct 2026 20:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792095809; cv=none; b=Z7fHTTqgipY5ZXVAhyrDgLr8L/V5hWs51vPg68IjC04jFkg05GNrEaYWpV9P6OtzM5gipbhUfDPwMv+ikatxa1b261L08SXmaS96GXqgLW3dnN04VGAUVm1LbEyBrDE4deAwjCfAmXEOkQCaxfaM8oKrhXb4P+AxoAMy+MGmndQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792095809; c=relaxed/simple;
	bh=PFLnmwlTM4FhvgLEp2HJEOMnKZnZqorNEOllu2ygZEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+FzWU70PAOF205RRsRrA1c3k2UpS8rkqtwwxe3jP2RGg0XviMTXL7KJGeROGcTib64fjbsZi2mMRXI+Iemf3TMmHawO9cRCM33DiAMsID3s3Pu7kLl053KFwayjQQOb10fcAPCaEyxV6WG/blzoYlxjS432iTmhwG5apxijdZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVnuI3Y4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVnuI3Y4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D731F000C4;
	Thu, 15 Oct 2026 20:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792095806;
	bh=xXwDHzZuhe8u9SnlulaNCevEzS5Sc4vDCzCCYZ3VINo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WVnuI3Y4cgeI3lDXIGx7Okwtdp4PdQ/99g27WTcH74G5UI8uavEe3tgd+j3gfuhM7
	 qssL+PqjcEvuZo3gV5S7LPBuNU3dE33zXQX8ZpH7NwYSclxY9W94j4A5onEhL7ynYX
	 BwDSnnEnjfmcansnnrLfxELcpxG4iVQEUcCUBX4YzZv+XYl2DUgP80G1I48tJmcftu
	 KjOcAMd+vvJBlw0bTvpELJ4CsnfLqC6gJnK5zwhE65OXBxyUQjkq415L3Tp/Oiu10K
	 9qStRHaRmep/1GnNUuHMmUCEwmkUiHT1z9GxDQR8MlVVpB02/mUUpmM+hYw0HKrNb4
	 UPvDvnj93Q27Q==
Date: Thu, 15 Oct 2026 15:23:23 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jeremy Dean Clifton <deaner92@yahoo.com>
Cc: devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v3] dt-bindings: pwm: Convert NXP PCA9685 PWM controller
 to DT schema
Message-ID: <179209579979.3002119.6334359092410993613.robh@kernel.org>
References: <20261012140346.3065-1-deaner92.ref@yahoo.com>
 <20261012140346.3065-1-deaner92@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012140346.3065-1-deaner92@yahoo.com>


On Mon, 12 Oct 2026 14:03:46 +0000, Jeremy Dean Clifton wrote:
> Convert the NXP PCA9685 PWM controller binding to DT schema format.
> 
> Changes from the text binding:
> 
> Document the 'reg' property and make it required. It was missing
> from the text binding, although the example used it and the device
> cannot work without the I2C address.
> 
> Rename the example node to the generic 'pwm', as required by
> pwm.yaml.
> 
> Describe both cells of the PWM specifier, and state that 'invert'
> and 'open-drain' apply to all outputs, as per the datasheet (INVRT
> and OUTDRV bits in MODE2).
> 
> Assisted-by: LLM
> Signed-off-by: Jeremy Dean Clifton <deaner92@yahoo.com>
> ---
> Changes in v3:
> - Full name in From, Signed-off-by and maintainers. (Jeremy Dean
>   Clifton)
> v2:
> https://lore.kernel.org/all/0aabb9f2-a144-4267-b67e-a0972d228f2a@yahoo.com/
> though the storage width was widened.
> - Use the same name in 'maintainers' as in the Signed-off-by.
> 
> v1:
> https://lore.kernel.org/all/20261006033518.34332-1-deaner92@yahoo.com/
> 
> The schema and commit message were drafted with AI assistant.
> I verified each property against the driver source, the
> PCA9685 datasheet and the binding. Passes make dt_binding_check.
> 
>  .../bindings/pwm/nxp,pca9685-pwm.txt          | 27 --------
>  .../bindings/pwm/nxp,pca9685-pwm.yaml         | 62 +++++++++++++++++++
>  2 files changed, 62 insertions(+), 27 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pwm/nxp,pca9685-pwm.txt
>  create mode 100644 Documentation/devicetree/bindings/pwm/nxp,pca9685-pwm.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

