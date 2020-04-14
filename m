From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] pwm: Add missing '\n' in log messages
Date: Tue, 14 Apr 2020 12:09:49 -0700
Message-ID: <19df87f5d093a6c2721316811aca1c90d287bf1d.camel@perches.com>
References: <20200411153528.30130-1-christophe.jaillet@wanadoo.fr>
         <20200414135827.GB3593749@ulmo>
         <f13a8754-3866-d3d2-eaff-29cb6d14ff8d@wanadoo.fr>
         <20200414184925.GA12862@kadam>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from smtprelay0211.hostedemail.com ([216.40.44.211]:41858 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2504730AbgDNT25 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 14 Apr 2020 15:28:57 -0400
In-Reply-To: <20200414184925.GA12862@kadam>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Thierry Reding <thierry.reding@gmail.com>, paul@crapouillou.net, u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

On Tue, 2020-04-14 at 21:49 +0300, Dan Carpenter wrote:
> Huh...
> 
> If you look at dev_vprintk_emit().  It looks like if
> create_syslog_header() returns a string then vprintk_store() will add
> a newline.
> 
> I guess that means that dev_printk() can't be used to pr_cont().  And
> probably that's deliberate because using pr_cont() after boot is racy
> anyway.

Perhaps that's true, it didn't used to be.

There are couple dozen or so KERN_CONT uses after a dev_<level>
without a newline, so those _might_ be broken, but I don't thinks so.

$ git grep -P -A10 '\bdev_\w+\s*\(' | \
  grep -P -B10 "KERN_CONT|pr_cont"
