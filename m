Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6CD3955E4
	for <linux-pwm@vger.kernel.org>; Sun, 19 Jul 2026 14:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784472558; cv=none; b=BBR8eKupZTGgjZW00W0To5qDQuMhSvPeJAZ+BrQc64hCnp1hfdYfPcDQGhtz8sBjbf1I19Kih5Edhst3V2PPAJ5i2NPLj2Gs2E5dlun6jup8dk9eD2VGr6Cdch6T4M8/reZ5zosJ3J9Avl+VDVGjFsU9b/nzxOIBM3sfzMXJPMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784472558; c=relaxed/simple;
	bh=Q7gzfp1xZ2LJLRXakoxDM6BFrJKfq47cA5ROeBV11tM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QbNYV9zFRKYrao0Li+8K8P3FKBEAqSt6yCot+uzWLklVp43yoEcVkArrjzKV2qKXLLZbEA5Iho9T6QeDxUBXhE4jHckJMEfXYSfPDaaiOhWAdSBY8/LQl7FyGCCmjEosSVV9/adR+6CzT0uvjaI3a3sFr5woxR90c6gUIlPASs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bALFb5vg; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bALFb5vg"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38e3efab7e0so2114833a91.0
        for <linux-pwm@vger.kernel.org>; Sun, 19 Jul 2026 07:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784472556; x=1785077356; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=G8ozcmP5Do3BF80PgSf++jutnr7umepQsuoe/U76RbE=;
        b=bALFb5vgoVSnztkqrbJBw9i/AEV1eonjxaninheOn5ONRjFsYUejuTDwskloMMNpd2
         iHJ2vzh6f8GFhmZsDKWpF/JVyOMyLbb4pqql6uXhMdHJP9It3UawsMPizOxoWt6gBE8W
         RjVbWH95UZnXPSXruIc6WSKsOGrcIIu3m3GyqZVZmnK28Pi0OZ/yaCbXLovlAvF64+Ic
         1UUPST/SkJA0XsJ0JFu1AAlUKSv5wAqK0mz7yPg5SWFTsVC3zge8PzF+38OITz2N2er0
         +UojSmYaIpUTiB6sj8uNbFdOMCqKqAT9ZGhyA4pMeM3OudI3g1ZFwNzWdtTDOGcl/DY3
         va9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784472556; x=1785077356;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G8ozcmP5Do3BF80PgSf++jutnr7umepQsuoe/U76RbE=;
        b=KTixwxmRJg2wFVyGbFTs8HzN1oj//3x/iGn0Qvwbljgk2KZntea4GrzDGkXdyk6snM
         YtqSZ07SwyC8lAjPWO7rkl++ivjtoJWP6KkHg9D+MPqpDkDVM6g9k0vJbYnCy1Jtv4zf
         ho1hRvaPQgy+AB19T9T074J74OtH4fvif/Z7QkppA95DnEzH4gnzg1BuHypPs9BziJQZ
         yjil3wthuSAOKCfLQzdJ8L8CqckABOxjSu4omSHIkkDRXPvc5+hOlgMUwSVIgcxzkWl+
         UtPm15WpZfwiMQkYY7n4lswYTlcwjok7o0ML7v73pj7AEEOjXA1tadahGoZ7DvV3K+DH
         Bzbw==
X-Forwarded-Encrypted: i=1; AHgh+RpejHg9nVJqjOdjWdACHi/U8bKDbshUPFjuV7KTIYIUwr3x8X0zGUtNE9bRJuBA9YcgP/xH3w7mMbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQM4tLZOEtMM7ji31wvWP7VNJZorYrZhE/MudXeoovz+QUqOyV
	qTxOG33FWjErOumwxBUdiBdCFnMMnfzjEOfV1z7CqtUxVhRkYxogOIwtfHfphA==
X-Gm-Gg: AfdE7ckHo9CuzR81P3TaFSyhzo7Nlu1dNqfwVGQ6+ql3X3T7Ha0uknKzqf7Apc+1SUe
	b6ePY744vjjnECSrDQ6EHuMzVlqhAEW19Wbl+owMkjQVeH0+KOPSn6PFI+QkO7u8z9di8dnlDVG
	FDBPTTM5nFsayNaDoIynSyXODh7CiFOK2DPkmpenwzwIfaEieuB8qNhrJIGDncCTaKnyDD1OcxG
	1ur7sGRrj06o1b3TrzAKrshq40VCnLU+FjPk55+tUsfFzeMjr2wTKKa3YFdQsFB5LwxhQFqvECf
	k5pEr/EZZvUW/E61pkbejmmvlCvL5nzL1bFRHtuF/tg0BKRbSckioP4taxfrfpMYyutMsTasD04
	hyecRqNbXkLOzUDClnTknOFXBUVfY/FI6XJe+Re9znQIY3wuj3t3Dr6b5cdo1i6pWyd+79kMzQs
	6ae0vgXGf9pFcIZ0o=
X-Received: by 2002:a17:90b:5644:b0:387:d5bd:622e with SMTP id 98e67ed59e1d1-38e4b6828cdmr8514207a91.17.1784472556341;
        Sun, 19 Jul 2026 07:49:16 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e3a0d82d1sm6034463a91.10.2026.07.19.07.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 07:49:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 19 Jul 2026 07:49:15 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chris Packham <chris.packham@alliedtelesis.co.nz>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Darrick J. Wong" <djwong@us.ibm.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 5/6] hwmon: (adt7470) Register as a PWM provider
Message-ID: <f882feec-c764-4990-8a11-186c028b6cdc@roeck-us.net>
References: <20260717-adt7470_thermalzone-v2-0-a55147958fad@gmail.com>
 <20260717-adt7470_thermalzone-v2-5-a55147958fad@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717-adt7470_thermalzone-v2-5-a55147958fad@gmail.com>

On Fri, Jul 17, 2026 at 05:59:18PM -0300, Luiz Angelo Daros de Luca wrote:
> hwmon: (adt7470) Register as a PWM provider
> 
> The ADT7470 features four PWM outputs that can be used to control fans.
> Previously, these were only accessible through the legacy hwmon sysfs
> interface.
> 
> Register the ADT7470 as a generic PWM provider. This enables standard
> Device Tree PWM consumers, such as "pwm-fan", to use the device through
> the "#pwm-cells" property.

Use case, please.

Thanks,
Guenter
