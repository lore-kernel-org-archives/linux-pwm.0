From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH] pwm: atmel-hlcdc: Fix default PWM polarity
Date: Tue, 17 May 2016 14:08:03 +0200
Message-ID: <20160517140803.078e3f5e@bbrezillon>
References: <1463476352-7485-1-git-send-email-boris.brezillon@free-electrons.com>
	<20160517110005.GA26166@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:59738 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751721AbcEQMIH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 17 May 2016 08:08:07 -0400
In-Reply-To: <20160517110005.GA26166@ulmo.ba.sec>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-arm-kernel@lists.infradead.org

Hi Thierry,

On Tue, 17 May 2016 13:00:05 +0200
Thierry Reding <thierry.reding@gmail.com> wrote:

> On Tue, May 17, 2016 at 11:12:32AM +0200, Boris Brezillon wrote:
> > The PWM device exposed by the HLCDC IP is configured with an inverted
> > polarity by default. Registering the PWM chip with the normal polarity
> > was not a problem before commit 42e8992c58d4 ("pwm: Add core
> > infrastructure to allow atomic updates") because the ->set_polarity()
> > hook was called no matter the current polarity state, but this is no longer
> > the case.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > Fixes: 42e8992c58d4 ("pwm: Add core infrastructure to allow atomic updates")  
> 
> That's not technically correct, because it's the driver that has the
> bug. The core change merely exposes it. How about if I sort this into
> the pwm-atomic branch and reword the commit message accordingly? That
> way things should all stay bisectible.
> 
> Then again, given the breakage caused by the pwm_args patch I suppose
> it doesn't matter much because that's part of a stable branch that I
> can't rebase.

If I understood correctly, you plan to rebase your pwm-atomic branch to
insert this commit before commit 42e8992c58d4 ("pwm: Add core
infrastructure to allow atomic updates").

Could you consider taking the following commit (or something similar if
you already have a fix) as the first commit of your pwm-atomic branch?

Sorry for the mess around the introduction of pwm_args and pwm_state
(that's not an excuse, but I've reworked this series so many time that I
forgot to check bisectibility on the last versions :-().

---
From ad73fa3a56c7320979425d64ab54c09b9d83d4cf Mon Sep 17 00:00:00 2001
From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Tue, 17 May 2016 13:55:02 +0200
Subject: [PATCH] pwm: Fix pwm_apply_args() call sites

pwm_apply_args() is supposed to initialize a PWM device according to the
arguments provided by the DT or the PWM lookup, but this function was
called inside pwm_device_request(), which in turn was called before the
core had a chance to initialize the pwm->args fields.

Fix that by calling pwm_apply_args directly in pwm_get() and of_pwm_get()
after initializing pwm->args field.

This commit also fixes an invalid pointer dereference introduced by
commit e39c0df1be5a ("pwm: Introduce the pwm_args concept").

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Fixes: e39c0df1be5a ("pwm: Introduce the pwm_args concept")
---
 drivers/pwm/core.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 680fbc7..22cf395 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -128,13 +128,6 @@ static int pwm_device_request(struct pwm_device *pwm, const char *label)
 	set_bit(PWMF_REQUESTED, &pwm->flags);
 	pwm->label = label;
 
-	/*
-	 * FIXME: This should be removed once all PWM users properly make use
-	 * of struct pwm_args to initialize the PWM device. As long as this is
-	 * here, the PWM state and hardware state can get out of sync.
-	 */
-	pwm_apply_args(pwm);
-
 	return 0;
 }
 
@@ -627,6 +620,13 @@ struct pwm_device *of_pwm_get(struct device_node *np, const char *con_id)
 
 	pwm->label = con_id;
 
+	/*
+	 * FIXME: This should be removed once all PWM users properly make use
+	 * of struct pwm_args to initialize the PWM device. As long as this is
+	 * here, the PWM state and hardware state can get out of sync.
+	 */
+	pwm_apply_args(pwm);
+
 put:
 	of_node_put(args.np);
 
@@ -754,13 +754,20 @@ struct pwm_device *pwm_get(struct device *dev, const char *con_id)
 	if (!chip)
 		goto out;
 
-	pwm->args.period = chosen->period;
-	pwm->args.polarity = chosen->polarity;
-
 	pwm = pwm_request_from_chip(chip, chosen->index, con_id ?: dev_id);
 	if (IS_ERR(pwm))
 		goto out;
 
+	pwm->args.period = chosen->period;
+	pwm->args.polarity = chosen->polarity;
+
+	/*
+	 * FIXME: This should be removed once all PWM users properly make use
+	 * of struct pwm_args to initialize the PWM device. As long as this is
+	 * here, the PWM state and hardware state can get out of sync.
+	 */
+	pwm_apply_args(pwm);
+
 out:
 	mutex_unlock(&pwm_lookup_lock);
 	return pwm;
