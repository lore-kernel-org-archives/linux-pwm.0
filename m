Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FAF3955CB
	for <linux-pwm@vger.kernel.org>; Wed,  5 Aug 2026 14:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785941869; cv=none; b=cZo00jUgWVYkG/bVVMHP2QHsq8mYNzymmKRMrkqjEoJQ/6r9CW3hTwVhnLMxiD28CVQfuCnb3QbxWiSLn72jJAYW3+8JCAfpevK4b6s7t+IKL3TlxjTnevGvqi7zNY4htMMEgVGNO67oG+Qs6aKAyZboMFWL8faHix6SL+moToE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785941869; c=relaxed/simple;
	bh=auUdmdF5BPs6K3sasWXSTlqxTXnk6OB3PFSBU6ek2kI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gw3E9gXJ27UWtETn6+jo/MgHphCZ+nTpOcnpN7HpumXiEqtcS3jrZwPrcfqN9+Sr5GRyenI4yZRiWSU2pF9fnU9b1Te45AjTwgazvMQmWORA8ZuxfQ/cV0MxeN9o0xzEUMjN+DJP6a5HkpPynt9hHnIMOtKJbHZk32tA6bW6000=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lFBG9s3v; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFBG9s3v"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-ca7bea5e5b3so883640a12.1
        for <linux-pwm@vger.kernel.org>; Wed, 05 Aug 2026 07:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785941867; x=1786546667; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=J4cCWm9J7oW4ALooS0cfmzE8SO2jTvYvrPbMn1sZeYQ=;
        b=lFBG9s3vLYhuGQ1nFEHICVO6l+7rBSUHtF8bLGWCA94qLxTpFBeh1R91HOJJhnc/a+
         ClbUax7XohkZm0bBLOodmCLM13+TOmTbDNbe02t4ryxVuB6LAlnlawd81dxD5KGuFecW
         oOa1T5TLt/YAu+/iKstYKSHfAlPGVYwSBcwNVA+MeMwkfcT6RO49hFphvt5aun3R2TQ8
         vsZOGFCgxKzNwx571LSi0swiekiPIa8PlYT70dZkZeVxb8ed+YrRToPubzvliF4nIRvf
         y7O91t+DDTtgTrA1zTcKeH8Z1wk+oQSk0aMvM5D3xc4PhbOfnUJfaNeu54dFxRYplKWF
         WQTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785941867; x=1786546667;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J4cCWm9J7oW4ALooS0cfmzE8SO2jTvYvrPbMn1sZeYQ=;
        b=WJdlj84d9dzIy9KnUE6FispaqFyyO2Y31dWrox6nsi+qNNVzT3fCBWpHxVQZbOH3Vf
         /wXakUdi/IWUMfdyRNiBYwEHCCUYKzXPm8VFkIkGTxbuLP1WDOLNvXoUMlN8dvcFclF9
         LqxYvTiAhrY31HS8OKCXr7ZOltyZ5CXg9y9OPG+rUf0AYjpKLp6hHO8NmAgtz5xjIiEC
         Oz5azYKMWTpJXs7P5FecZCVAWGA6e63XnZJdw22DpD/0fMMC+94dEGUccnJpaUCgnlNo
         e5RC3R2eyfrA0P9xw8KVOqWyJkvRsdc/mOKgj6p3bBZ8dTkXysiCq/ZhN0a8+YciTcdv
         RqbQ==
X-Forwarded-Encrypted: i=1; AHgh+RoqyvylIs+SfJtU//weDmHuZ5eo+rt69t2bNqaTq2fKNcPlGGBWeueWV+Qd0BC2WvZIl7Z0FLNijto=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZez7a0tstAw83sKvRzvUXom1ksoLu6k19540598toTTnzC5Mz
	a4VHVnXWSl+cKYkN8QPDm9clgLVMwNM5ST4DSLOiJeKKQ9n+MiM+wJYa
X-Gm-Gg: AR+sD104whzpoAApy6afJYrMh7VmxKmfzaBXddNCIPAW5B9pDDLMp8YLQ2ypr1jUifC
	53nXhCh0emF1FHCjMhm+cD8Tcz8TJiY52YdXBV07MIQDghy2RaPN036fFfjikudbADZnRAc7ptb
	B/byzJsQre31oipsWm01VLXoW2biMFC2jr262AaL5mGjZVEKM8yFGYEtOleu991IkjTcuPFV/P/
	QeWKwBGAVqpsBMILUKGrOrzo0Wozx4Lnv2NWBRmNixznDfGZuZTWY36NaisRn1WOj/njQcXkKle
	Qagqia9jSrBDUXuYSLrnrA0t0FJX5rpj6GKKJN8oORUDfHDHBiDpoAwvS94hlEBpK+W7Nj0R4rS
	EJqfkBZwX2RJIMhFsX34LIunQrOo7M935h9HppQkJbgz45bVHT4PhWkvsdTuUkmWa0DhnOK9VCz
	8fwzn2q3ywpAyBWX4h0mHzpk3OVUP1bNgznFhmbNZ+q1ySABZSkv+lbUXeMVeYLpjgoZKT5ORWv
	A==
X-Received: by 2002:a05:6a20:7f99:b0:3bf:49c8:f7b with SMTP id adf61e73a8af0-3cb85e2ae72mr8403324637.13.1785941866629;
        Wed, 05 Aug 2026 07:57:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fca6576b7sm13556187c88.7.2026.08.05.07.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 07:57:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 5 Aug 2026 07:57:45 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chris Packham <chris.packham@alliedtelesis.co.nz>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Darrick J. Wong" <djwong@us.ibm.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [hwmon-next PATCH v6 1/4] dt-bindings: hwmon: add adi,adt7470
Message-ID: <d4d9b9f3-960c-4680-9779-74fdfa3f0355@roeck-us.net>
References: <20260805-adt7470_thermalzone-v6-0-5605a5f95467@gmail.com>
 <20260805-adt7470_thermalzone-v6-1-5605a5f95467@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805-adt7470_thermalzone-v6-1-5605a5f95467@gmail.com>

On Wed, Aug 05, 2026 at 10:15:17AM -0300, Luiz Angelo Daros de Luca wrote:
> The Analog Devices ADT7470 is a multichannel temperature sensor and
> PWM fan controller. It supports monitoring up to 10 external
> temperature sensors and controlling up to 4 fans.
> 
> Add the device tree binding documentation for it. This includes
> support for the thermal framework by defining the "#thermal-sensor-cells"
> property, and models the fan control lines as PWM channels by
> defining the "#pwm-cells" property.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

Applied.

Thanks,
Guenter
