From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] pwm: Add missing '\n' in log messages
Date: Tue, 14 Apr 2020 12:04:32 -0700
Message-ID: <b867ee8a02043ec6b18c9330bfe3a091d66c816c.camel@perches.com>
References: <20200411153528.30130-1-christophe.jaillet@wanadoo.fr>
         <20200414135827.GB3593749@ulmo>
         <f13a8754-3866-d3d2-eaff-29cb6d14ff8d@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from smtprelay0090.hostedemail.com ([216.40.44.90]:45892 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728340AbgDNTn7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 14 Apr 2020 15:43:59 -0400
In-Reply-To: <f13a8754-3866-d3d2-eaff-29cb6d14ff8d@wanadoo.fr>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Thierry Reding <thierry.reding@gmail.com>, paul@crapouillou.net, Dan Carpenter <dan.carpenter@oracle.com>
Cc: u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

On Tue, 2020-04-14 at 20:30 +0200, Christophe JAILLET wrote:
> Being able to detect early missing trailing '\n' would help maintainers 
> and patch providers.
> 
> You are the 2nd person (I've added Paul Cercueil in copy of my reply) 
> who reports that he is thinking that it is no more required to add a '\n'.

The printk subsystem will, for every printk, check
if the last printk has a newline termination and if
it doesn't and the current printk does not start with
KERN_CONT will insert a newline.

The negative to this approach is the last printk,
if it does not have a newline, is buffered and not
emitted until another printk occurs.

There is also the (now small) possibility that
multiple concurrent kernel threads or processes
could interleave printks without a terminating
newline and a different process could emit a
printk that starts with KERN_CONT and the emitted
message could be garbled.

See:

commit 4bcc595ccd80decb4245096e3d1258989c50ed41
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat Oct 8 20:32:40 2016 -0700

    printk: reinstate KERN_CONT for printing continuation lines
