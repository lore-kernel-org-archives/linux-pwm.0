From: Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [PATCH RESEND] pwm: ftm: fix clock enable/disable when using
 PM
Date: Fri, 20 Nov 2015 02:38:05 +0200
Message-ID: <564E6B6D.80006@mleia.com>
References: <1445142552-3530-1-git-send-email-stefan@agner.ch> <290ed017061ef41e1fe5c3fd5a523511@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mleia.com ([178.79.152.223]:41491 "EHLO mail.mleia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759194AbbKTAiH (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Thu, 19 Nov 2015 19:38:07 -0500
In-Reply-To: <290ed017061ef41e1fe5c3fd5a523511@agner.ch>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: thierry.reding@gmail.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 19.11.2015 04:04, Stefan Agner wrote:
> Thierry,
> 
> I realized that this patch did not make it into 4.4-rc1, while others,
> IMHO less important patches which have been posted later (e.g. sunxi
> whitespace fixes) have made it! :-(
> 
> Anything wrong with that? Or am I on your spam list? Note that this is
> already a RESEND :-)

You are not alone with this problem, I have unreviewed changes in
linux-pwm mailing list sent in 2014 :)

--
With best wishes,
Vladimir
