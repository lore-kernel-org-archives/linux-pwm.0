From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] pwm: Fix uninitialized warnings in pwm_get()
Date: Thu, 28 Aug 2014 11:03:14 +0200
Message-ID: <1409216594-31389-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pwm@vger.kernel.org

With some versions of gcc (e.g. 4.1.2):

drivers/pwm/core.c: In function =E2=80=98pwm_get=E2=80=99:
drivers/pwm/core.c:610: warning: =E2=80=98polarity=E2=80=99 may be used=
 uninitialized in this function
drivers/pwm/core.c:609: warning: =E2=80=98period=E2=80=99 may be used u=
ninitialized in this function

While these are false positives, we can get rid of them by refactoring
the code to store a pointer to the best match, as suggested before by
Thierry Reding. This does require moving the mutex_unlock() down.

=46ixes: d717ea73e36dd565 ("pwm: Fix period and polarity in pwm_get() f=
or non-perfect matches")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pwm/core.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 8c748b17f416..966497d10c6e 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -602,12 +602,9 @@ struct pwm_device *pwm_get(struct device *dev, con=
st char *con_id)
 	struct pwm_device *pwm =3D ERR_PTR(-EPROBE_DEFER);
 	const char *dev_id =3D dev ? dev_name(dev) : NULL;
 	struct pwm_chip *chip =3D NULL;
-	unsigned int index =3D 0;
 	unsigned int best =3D 0;
-	struct pwm_lookup *p;
+	struct pwm_lookup *p, *chosen =3D NULL;
 	unsigned int match;
-	unsigned int period;
-	enum pwm_polarity polarity;
=20
 	/* look up via DT first */
 	if (IS_ENABLED(CONFIG_OF) && dev && dev->of_node)
@@ -653,10 +650,7 @@ struct pwm_device *pwm_get(struct device *dev, con=
st char *con_id)
 		}
=20
 		if (match > best) {
-			chip =3D pwmchip_find_by_name(p->provider);
-			index =3D p->index;
-			period =3D p->period;
-			polarity =3D p->polarity;
+			chosen =3D p;
=20
 			if (match !=3D 3)
 				best =3D match;
@@ -665,17 +659,22 @@ struct pwm_device *pwm_get(struct device *dev, co=
nst char *con_id)
 		}
 	}
=20
-	mutex_unlock(&pwm_lookup_lock);
+	if (!chosen)
+		goto out;
=20
-	if (chip)
-		pwm =3D pwm_request_from_chip(chip, index, con_id ?: dev_id);
-	if (IS_ERR(pwm))
-		return pwm;
+	chip =3D pwmchip_find_by_name(chosen->provider);
+	if (!chip)
+		goto out;
=20
-	pwm_set_period(pwm, period);
-	pwm_set_polarity(pwm, polarity);
+	pwm =3D pwm_request_from_chip(chip, chosen->index, con_id ?: dev_id);
+	if (IS_ERR(pwm))
+		goto out;
=20
+	pwm_set_period(pwm, chosen->period);
+	pwm_set_polarity(pwm, chosen->polarity);
=20
+out:
+	mutex_unlock(&pwm_lookup_lock);
 	return pwm;
 }
 EXPORT_SYMBOL_GPL(pwm_get);
--=20
1.9.1
