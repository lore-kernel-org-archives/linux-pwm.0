Return-Path: <SRS0=HNCL=B3=vger.kernel.org=linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B6CC433F2
	for <linux-pwm@archiver.kernel.org>; Mon, 17 Aug 2020 22:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F61C2072E
	for <linux-pwm@archiver.kernel.org>; Mon, 17 Aug 2020 22:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597702265;
	bh=U1nriebAkZy2CMiC1Ae930tzK6CKGw9soxdnvSjgE6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dAKGAlwtPYvBjZE3Sw2VIsgFh63SnZyPlXV6ytaMcBNgyF0HITxlREYmbGt6m14op
	 0hmzSF9aJ0A9YvxEFpFn0zQ7awl7WWOhvhhGfXSNkSoDunBmL04p+Wy0066TzUJres
	 PfdziY6dA+lFaf8pbk+9Nn412NRFbPNURGbGDfcs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729671AbgHQWLF (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Mon, 17 Aug 2020 18:11:05 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:40099 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728639AbgHQWLD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 17 Aug 2020 18:11:03 -0400
Received: by mail-il1-f194.google.com with SMTP id p18so12083190ilm.7;
        Mon, 17 Aug 2020 15:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w62w5Qx3ojDiNU6oOUvlsJSHzBBTEkBiVAzdZrJuQhQ=;
        b=OB4K/6creD9rqHTIvj2D+xwJV0WfI4b2guwYJd3hdQuoA/cjcVKYaGDyC731Wy3Xzu
         6t15DkrcQoicj6+Prv2kUbduwIghgk/UlgUh8aeTmrpO7rblVmdxJWWWwDalQgnZyjEn
         Uk6zKV+HXmYLo5PRABsubUCTcDwk3ebmw34Io35Fmz4A4eSyfdwGRJ5Fun6GcXDTqIRA
         wgxktH0+LeMosDCuxlIvOBF6JX/HQKDLTQhCslZa5osEPnyEy+MwkfIP9Ep95gfS+gfb
         Lc4Lbv6iSpbqPmYJAoHeSA1UcZEBk4RKDuv+EkmszYPjhwMiBFAKFi6OYBZX3e7kWw3U
         7BtQ==
X-Gm-Message-State: AOAM5310kfAsBi6WsGAuuEPle3sTXF15PYwKIlgns6+qrXcVpdEZ4YgN
        3q5gdiiSezyMP++uXAXbTg==
X-Google-Smtp-Source: ABdhPJwYqU2zPE2WoMlgszKfcIG8MuKYmbxnJLn346n5uKKWlMnMyd9kdgFRyl9qlgus4CVKTRkIOA==
X-Received: by 2002:a92:d0d:: with SMTP id 13mr15805752iln.109.1597702262390;
        Mon, 17 Aug 2020 15:11:02 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id v2sm3403307ilh.33.2020.08.17.15.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 15:11:01 -0700 (PDT)
Received: (nullmailer pid 1665242 invoked by uid 1000);
        Mon, 17 Aug 2020 22:10:59 -0000
Date:   Mon, 17 Aug 2020 16:10:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Prabhakar <prabhakar.csengg@gmail.com>,
        linux-kernel@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pwm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH 4/5] dt-bindings: pwm: renesas,tpu-pwm: Document r8a7742
 support
Message-ID: <20200817221059.GA1665190@bogus>
References: <20200806183152.11809-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200806183152.11809-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200806183152.11809-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, 06 Aug 2020 19:31:51 +0100, Lad Prabhakar wrote:
> Document r8a7742 specific compatible strings. No driver change is
> needed as the fallback compatible string "renesas,tpu" activates the
> right code in the driver.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
