Return-Path: <linux-pwm-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:55657 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751507AbeDILrk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 9 Apr 2018 07:47:40 -0400
Date: Mon, 9 Apr 2018 13:47:36 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] pwm: rcar: simplify getting .drvdata
Message-ID: <20180409114736.krzyciz2gyotbm72@verge.net.au>
References: <20180405172552.8720-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405172552.8720-1-wsa+renesas@sang-engineering.com>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

On Thu, Apr 05, 2018 at 07:25:51PM +0200, Wolfram Sang wrote:
> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Only build tested. Fixed numerous times in other drivers, however...

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
