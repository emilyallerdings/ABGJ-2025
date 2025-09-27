extends Resource
class_name Corruptable
@export_range(0, 1) var minCorruption : float = 0

func filter_corruption(lerpProgress : float) -> float:
	if minCorruption > 0:
		if lerpProgress > minCorruption:
			return (lerpProgress - minCorruption) / (1 - minCorruption)
		return 0
	return lerpProgress
