Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F362810F1
	for <linux-pwm@vger.kernel.org>; Tue, 21 Jul 2026 02:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784599986; cv=pass; b=KgLTAnGVSXjwPAfE8Rt3W1gUIwXJ7/0PwNbdvSN2PbZZoah6UvPpH2Lrd0XHNaELJ2SFhMaAfSFKHUIhxXsAM4mI8Lvs7JhUlrBol0pZc5uHznNktt7fh+MObp0ABLQLsRe85BjcTJ7CCpPXpj3KFRsm6LZ/ZqRjfdqNNnm93jw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784599986; c=relaxed/simple;
	bh=Ks4hlPwjiSSqgNz3Ei+KPrG/m6doz7SbHxytNQOm61g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pKQYge6t94EF0tqgYFSwGn1w6OIt+tiwUr51dLagtb4LErDLUnHL3gHNYko+zC8pCo6snB4FTCFIoK8fonIjoXabfhtKaNJPm4VaIAcMjzq/13qcemBMM2RXY5VG24OTy0CLNGd7F8C+iFcQ6TmDsFEZD8v4G0SEO/3tzCRtW/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZLPxgzY; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZLPxgzY"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c16794450aeso750226366b.2
        for <linux-pwm@vger.kernel.org>; Mon, 20 Jul 2026 19:13:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784599983; cv=none;
        d=google.com; s=arc-20260327;
        b=YuKngbeNIchU2VzQM3VzjzZb4XwpIrOnvjunxwheZBIhDPvrznuNsgBcI8xt5sQ6sQ
         OyP8CvTDMd+cAKBd68bk2NdCGBYkEZN1WN4a/2dxgSocamziRDX63+yl9volWc0yE+ye
         1aigYiymaAsPJNDL9TMsQWqfww3G7FQqQm+20HYDLzteYNynLZaa59VaffOlG/emqZDA
         k9CdR+ZJfBFVILS0SnoLUdO7az4e5yiOFXH/jOW/I1wINLsieYS2f6trmx8+etEZf43D
         eQy8971lzy39L/SbmB8WZfNYLE+jfhJBsSMwkZKq0FMrkGd092p+Vt7HH+KmPFIOmkJ8
         QlvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Kod/uxXV0+IwWSdU1EXXNkwfBulsiSvEkeGxFmls+yM=;
        fh=jtTrUaXOZADLsb1njdgm9rzj62qNsUGVVF796HyGuEo=;
        b=hradOYV8C/imNawI5GTeE7Ex5/3u3HaNrtbFZvIESS+UyhtK3iF5ahEdluessuiFIA
         k8ojIRkkvma8YqgqmFZ1A9mZNQKT37b/q5o+tLextbmDiKuGtoMXGHgGKlahhzaLdji3
         quynlkVaH8yLVbcxRLvBGL5LQM4Gi9p0exs4pMIJ/qY/O9DuB/adH/Etl2lz3I4YXSD/
         jXlXWSAGmyXm4HUtuhhLV9Bvayv8ZDSmPdcJpNBEMWd1vWb7/qqPvGr8HjDi0y3PkUY8
         OlHsqfxlbXWpUH2xmYSOyN/7AKWWn2T9eaiwe/JNPDzisrz5WEpW95RcSnqPe37mj3BK
         jPbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784599983; x=1785204783; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kod/uxXV0+IwWSdU1EXXNkwfBulsiSvEkeGxFmls+yM=;
        b=hZLPxgzYAY10fGqW7FAPnvqZTmPAZjzeZoiDPT5m8bIvk3AsHKGZarLV4vz5RrNWs5
         zoIj+uHLuf25n69oZ8YLcfIIxmrL1Dr38yzy8dgPE/b8RtfC18PWfLL72tcJphOA+lSP
         Uu4ULlWicgxAeVMzAQ/NlEfQKVkvhWrB+lQgdtGt60y43fKliA12IQyht/O6UsGIFJrJ
         lCM+T6GCsRWy6NIGDRyIClyUSsZ1HFOR99oLNoGxhEilX1CZDdHnWflv5Qwb1omykbc9
         1PAUMPJ6NLKgRScMvAiByJ7pWco94gLs+4nZ/ZXMFi/3fIgB9jGvW4zz0uhMbyjxw1HJ
         tOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784599983; x=1785204783;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Kod/uxXV0+IwWSdU1EXXNkwfBulsiSvEkeGxFmls+yM=;
        b=oEowGjbgWRYN4MwSGzpKXBWK3zooY1dXAJAiF5XwSAeg+ykk4EmgQiSVoHsCDGGZzG
         MJ7MKeyLScFK8W2Rch3JfftHbN2y6DRpkCRTJiY6PCz+DYde2gIwztEo1yLRhSwiouV/
         k0FGF1GgBzIWau2mNQ2vhEYLu9P7Ie3NmqNAErqQYgH+jrrWEKKVC0QEdEXb0NWssWl7
         s2mLJocAFiueGYxa7X9rn+RZtXjBV6U+tymNimU59r2jnx/zSBC2PbBrlwbMJzB5SD7O
         cdiN/L94VqOOK6MhTsGOOT0rywP3aUUR4J6pCMTV8WxHONzbiD0MDcpCxipi5kYJ6bjh
         mlkA==
X-Forwarded-Encrypted: i=1; AHgh+RqIcQVdHCBxmK3NcMuCQVHkwOT2Q1eoMPM+WtTr6c44E62xOC411Rsa9UyQgXSco2jT29RtqkB+X8o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyxl6F1X5MwuZOAXqNqMu+5mVzpVmRZeoFotMNjxddXXDQIS4I
	eNoMdLQbrO1VDJIu+RiQVcaWeW084WrUl+4ZjR+YvYrXyH9Lyp+drg/xfpiGnLxYfm35Oc6OfSD
	2JBcbS3rcq63IjzYDXF6HlKFqX1mqYYE=
X-Gm-Gg: AfdE7cnshTNzRDykukdW1J4R0k+lrofoxXzqHqN+au7sjxoJNJcF9+u7dYj3He49Joj
	mkU9ZwYimBkRARpCHgzc9Slmg1K/NpB2m6Jxd83mDS1PCHi1SO3HTivRNhyLEUXNii6EAH/HN/m
	VD3/S7daBqVY01YMGnthW3F4NG6YWB9nIBZnHlFWQ+LndzRN0Oveic38i5KsnBwiqrrLWYJgzBT
	abApXCFLbuUTEom/t8lMOFHNoNyi2NAYOXvxlySMmT3q9KxntdnIeAaSdhjdfBZtXUSB49E801Y
	9mW2xeHkgSbQXoZtH/M=
X-Received: by 2002:a17:906:9f84:b0:c15:ee0d:9a32 with SMTP id
 a640c23a62f3a-c16b46c2d56mr670202466b.21.1784599982941; Mon, 20 Jul 2026
 19:13:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717-adt7470_thermalzone-v2-0-a55147958fad@gmail.com>
 <20260717-adt7470_thermalzone-v2-1-a55147958fad@gmail.com>
 <20260720-placid-fanatic-shrimp-d2bcd2@quoll> <a8fba49c-bb72-4b3b-b598-4972304e0b4c@roeck-us.net>
In-Reply-To: <a8fba49c-bb72-4b3b-b598-4972304e0b4c@roeck-us.net>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Mon, 20 Jul 2026 23:12:49 -0300
X-Gm-Features: AUfX_myLShn4fOD2j01TxsjJLkkvEv0DLVF494Hq8Z0mAimraTmy0Vm02ScO--c
Message-ID: <CAJq09z6qQnKXgBnQKCey4u47hsJTjpYXPDvDZj76sXHZuj2emQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] dt-bindings: hwmon: add binding for adi,adt7470
To: Guenter Roeck <linux@roeck-us.net>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chris Packham <chris.packham@alliedtelesis.co.nz>, 
	Andrew Morton <akpm@linux-foundation.org>, "Darrick J. Wong" <djwong@us.ibm.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>  From the datasheet: "The ADT74701 controller is a multichannel
> temperature sensor and PWM fan controller and fan speed monitor".
>
> It is a fan controller which happens to use pwm signals to control
> fan speeds. It is not a PWM controller, and its pwm outputs are not
> intended to be used for anything but controlling fan speeds.
>
> Technically it is _possible_ to use the pwm outputs to control
> something else. But that does not mean that chip is a pwm controller.
> It is still a fan controller. I don't mind modeling outputs as
> non-fan-control pwm channels if that is what they are used for,
> but that must be clearly distinguished in both the driver code
> and the bindings.

Hi Guenter,

You are absolutely right. The datasheet explicitly defines the ADT7470
as a "PWM fan controller and fan speed monitor," and its internal
features (like tachometer inputs and thermal acoustic enhancement) are
heavily tailored for fan control. I agree that calling it a generic
PWM controller is technically inaccurate. I will revert the change and
describe it as a PWM Fan Controller, provided everyone is on board
with that.

Initially, I modeled the driver purely as a cooling device. However,
following Sashiko-dev's suggestion in a previous review, I converted
it to expose PWM channels so it could be used with the generic pwm-fan
driver (which indeed makes the code cleaner). My primary experience is
with DSA switches, so hwmon is a new area for me.

Whatever you and the DT maintainers agree on, I will gladly adjust for v3.

Best regards,

Luiz
